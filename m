Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbTHUFl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 01:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTHUFl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 01:41:28 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:39436 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262460AbTHUFl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 01:41:26 -0400
Date: Thu, 21 Aug 2003 02:40:47 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 7/10 2.4.22-rc2 fix __FUNCTION__ warnings net/irda
Message-Id: <20030821024047.1a393bb3.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 af_irda.c      |  220 ++++++++++++++++++++++++++-------------------------------
 irda_device.c  |   48 ++++++------
 irias_object.c |   35 ++++-----
 irlap_event.c  |  163 ++++++++++++++++++++----------------------
 irlap_frame.c  |   73 +++++++++---------
 irlmp.c        |    8 +-
 irlmp_frame.c  |   47 +++++-------
 irqueue.c      |   10 +-
 irttp.c        |  116 +++++++++++++++---------------
 parameters.c   |   54 ++++++-------
 qos.c          |   30 +++----
 wrapper.c      |   25 +++---
 12 files changed, 403 insertions(+), 426 deletions(-)

http://www.vmlinuz.com.ar/slackware/patch/kernel/net.irda.patch
http://www.vmlinuz.com.ar/slackware/patch/kernel/net.irda.patch.asc

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
