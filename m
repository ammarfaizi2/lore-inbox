Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbTHUEe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbTHUEe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:34:58 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:55815 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262399AbTHUEe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:34:57 -0400
Date: Thu, 21 Aug 2003 01:28:56 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 1/10 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/char/drm-4.0
Message-Id: <20030821012856.1fff203b.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

Good, with it is series of patches, fix all warnings that I found in 2.4.22-rc2,
exactly 1562, without counting those of my previous patch in ntfs with 190.
Like the one of the NTFS, does not touch the code absolutely, only printk's.
The patches of some headers are based on the 2.6, such as drm, irnet.


 drmP.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.char.drm-4.0.patch
http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.char.drm-4.0.patch.asc

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
