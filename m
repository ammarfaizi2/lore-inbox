Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTLRMla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 07:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbTLRMla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 07:41:30 -0500
Received: from mail.szintezis.hu ([195.56.253.241]:49515 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S265125AbTLRMl3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 07:41:29 -0500
Subject: [exec-shield] 2.6.0 INIT: PANIC
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: mingo@redhat.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Dec 2003 13:41:27 +0100
Message-Id: <1071751287.440.13.camel@gmicsko03>
Mime-Version: 1.0
X-OriginalArrivalTime: 18 Dec 2003 12:41:27.0556 (UTC) FILETIME=[41114C40:01C3C564]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

exec-shield-2.6.0-test11-G4 with 2.6.0 killed my INIT:

INIT: PANIC: segmentation violation at 0x8049f52 (code)! sleeping 30
seconds.

If i boot with exec-shield=0 at lilo prompt, everything is OK. If switch
exec-shield level 2 (echo 2 > /proc/sys/kernel/exec-shield) Mozilla
dying after start and X server too.

(Debian Sarge)



-- 
Windows not found
(C)heers, (P)arty or (D)ance?
-----------------------------------
Micskó Gábor
HP Accredited Platform Specialist, System Engineer (APS, ASE)
Szintézis Computer Rendszerház Rt.      
H-9021 Gyõr, Tihanyi Árpád út.2.
Tel: +36 96 502-216
Fax: +36 96 318-658
E-mail: gmicsko@szintezis.hu
Web: http://www.hup.hu/

