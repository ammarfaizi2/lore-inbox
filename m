Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTHUFrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 01:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbTHUFrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 01:47:33 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:2918 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262449AbTHUFrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 01:47:31 -0400
Date: Thu, 21 Aug 2003 01:30:30 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 7/10 2.4.22-rc2 fix __FUNCTION__ warnings net/irda
Message-Id: <20030821013030.312bdca3.vmlinuz386@yahoo.com.ar>
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
