Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132428AbRCaPwv>; Sat, 31 Mar 2001 10:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132429AbRCaPwm>; Sat, 31 Mar 2001 10:52:42 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:38927 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132428AbRCaPwW>; Sat, 31 Mar 2001 10:52:22 -0500
From: "Delbert Matlock" <Delbert@Matlock.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.3 compile fail (conflicting types) - Alpha processor - init/main.c
Date: Sat, 31 Mar 2001 10:49:48 -0500
Message-ID: <MPBBLFNMFLHJNJCJDPMCOEIBDJAA.Delbert@Matlock.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't turn up a previous reference to this with a quick search in the
mailing list archive, so here it goes.

Compiling 2.4.3 on an Alpha processor system failed on 'init/main.c' with
'conflicting types' errors for 'pte_alloc' and 'pmd_alloc'.  If I'm reading
things right, it's a discrepency between 'include/asm/pgalloc.h' and
'include/linux/mm.h'.

