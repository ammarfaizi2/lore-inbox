Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274302AbRITDyl>; Wed, 19 Sep 2001 23:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274303AbRITDyc>; Wed, 19 Sep 2001 23:54:32 -0400
Received: from member.michigannet.com ([207.158.188.18]:26129 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S274302AbRITDyR>; Wed, 19 Sep 2001 23:54:17 -0400
Date: Wed, 19 Sep 2001 23:53:28 -0400
From: Paul <set@pobox.com>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Cc: jdike@karaya.com
Subject: [uPATCH] Re: Linux 2.4.9-ac12
Message-ID: <20010919235328.K16708@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org,
	jdike@karaya.com
In-Reply-To: <20010918214907.A6707@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918214907.A6707@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Tue, Sep 18, 2001 at 09:49:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Needed this to get uml to compile:

--- 2.4.9-ac12-user/arch/um/kernel/sys_call_table.c.orig	Wed Sep 19 23:11:30 2001
+++ 2.4.9-ac12-user/arch/um/kernel/sys_call_table.c	Wed Sep 19 23:29:07 2001
@@ -208,6 +208,7 @@
 extern syscall_handler_t sys_setresgid;
 extern syscall_handler_t sys_getresgid;
 extern syscall_handler_t sys_chown;
+extern syscall_handler_t sys_personality;
 extern syscall_handler_t sys_setuid;
 extern syscall_handler_t sys_setgid;
 extern syscall_handler_t sys_setfsuid;
	
	tuntap (eg. using bootparam 'eth0=tuntap,,,192.168.2.1'
stopped working for me (but Ive just booted this
2.4.9-ac12...have to look around a little.)  no eth0 device
present in uml booted kernel.  Worked on 2.4.9 + uml patch)

Paul
set@pobox.com
