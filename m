Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbTHUEhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTHUEg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:36:59 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:8720 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262417AbTHUEfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:35:44 -0400
Date: Thu, 21 Aug 2003 01:30:37 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 8/10 2.4.22-rc2 fix __FUNCTION__ warnings net/irda/ircomm
Message-Id: <20030821013037.1a3edbfa.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ircomm_core.c       |   46 ++++++++++++++---------------
 ircomm_event.c      |   12 +++----
 ircomm_lmp.c        |   30 +++++++++----------
 ircomm_param.c      |   34 ++++++++++-----------
 ircomm_ttp.c        |   26 ++++++++--------
 ircomm_tty_attach.c |   81 +++++++++++++++++++++++++---------------------------
 ircomm_tty_ioctl.c  |   18 +++++------
 7 files changed, 123 insertions(+), 124 deletions(-)

http://www.vmlinuz.com.ar/slackware/patch/kernel/net.irda.ircomm.patch
http://www.vmlinuz.com.ar/slackware/patch/kernel/net.irda.ircomm.patch.asc

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
