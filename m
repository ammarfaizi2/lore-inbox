Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbTANOgT>; Tue, 14 Jan 2003 09:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTANOgT>; Tue, 14 Jan 2003 09:36:19 -0500
Received: from smtp.laposte.net ([213.30.181.7]:2743 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S262937AbTANOgS>;
	Tue, 14 Jan 2003 09:36:18 -0500
Message-ID: <00e901c2bbdb$563b8b50$2680a8c0@nordnet.net>
From: "Florent CHANTRET" <florent@chantret.com>
To: <linux-kernel@vger.kernel.org>
Subject: SMBALERT# thermal sensor signal for Intel PII in the kernel ?
Date: Tue, 14 Jan 2003 15:43:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi geeks and guru's ;o)

Even if I'm a developper, I'm not there for the moment to help you
developping this wonderful Linux Kernel. Later, perhaps ;o)

But, I've a problem with my laptop Sony VAIO powered by a bugged as hell
Intel PII Celeron (lot of customers from Sony have the same problem and
there is no support from this fuckin' company, nor from Intel, and I don't
think contacting Micro$$$$oft is the good thing to do).

My laptop randomly shutdown due to a bug in the thermal sensor of the PII
sending a SMBALERT# signal. There is no solution for NT fuckin' OS (only a
trick on "WinDaube" 98 (french expression for WinShit ;o))

I don't want to be on an unstable fuckin' system, so I decided to
permanently switched to Linux (I was always reticent, I was considering
Linux was the best stuff for server but not so ready yet for desktop :
crappy fonts, some applications missing or not so user-friendly, but I'm
changing my mind), cause there is a real support, and tha ability to see the
source code. Open Source ruleeezzzzzzzzzz ;o)

But let's go to the problem :

Here is the Intel stuff about the bug :
http://cipsa.physik.uni-freiburg.de/~zwerger/Vaio/Intel_Mobile_Temp-Prob.pdf
Here is the fix on fuckin' Windows 98 (as a curiosity) :
http://cipsa.physik.uni-freiburg.de/~zwerger/Vaio/indexeng.htm

So there is a software way to fix this hardware bug.

So I've build a 2.4.20 kernel without  all the APM,ACPI, PM at boot, CPU
Idle and "Machine Check Exception" but I've still the problem. The kernel
still answer to an SMBALERT# which cause the machine to shutdown.

So, before asking in the ML, I've searched on Google and Google Groups
without success (there is quite nothing about SMBALERT#).

I've grepped all the 2.4.20 source code but there is anywhere the presence
of SMBALERT# in a comment. I've noticed some codes about SMBus (which I
think include the SMBALERT functionnality) but I don't know if I can
deactivate SMBus in the kernel config and if it is safe to do it.

There is several functions in the kernel for SMBus so if I must patch the
code to deactivate this precise signal, any help would be appreciated ;o)

If I can fix it, I will try to convert all the consumers of the F-serie VAIO
bugged to Linux ;o)

Thanks for your answer and sorry if this is not the good place to post but
I've searched a lot before. I don't want to erase Linux to put a "Windaube
98" help help help ;o)

Regards and respect for your great work !
Florent CHANTRET

