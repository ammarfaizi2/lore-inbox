Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbTAOLMw>; Wed, 15 Jan 2003 06:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTAOLMw>; Wed, 15 Jan 2003 06:12:52 -0500
Received: from smtp.laposte.net ([213.30.181.7]:52459 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S265568AbTAOLMv>;
	Wed, 15 Jan 2003 06:12:51 -0500
Message-ID: <00bc01c2bc88$0d56c640$2680a8c0@nordnet.net>
From: "Florent CHANTRET" <florent@chantret.com>
To: "jw schultz" <jw@pegasys.ws>, <linux-kernel@vger.kernel.org>
References: <00e901c2bbdb$563b8b50$2680a8c0@nordnet.net> <20030115021128.GI21077@pegasys.ws>
Subject: Re: SMBALERT# thermal sensor signal for Intel PII in the kernel ?
Date: Wed, 15 Jan 2003 12:20:02 +0100
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

This is a PCG-F305 but all the old serie F of VAIO is concerned. The problem
don't appear immediately but later when the laptop isn't covered by the
guarantee.

Thanks for your link. Anyway, this is not really a "Linux on VAIO" related
problem, but an hardware bug on the Intel PII that can be solved by a
software trick cause the laptop doesn't crash on MS-DOS, WinShit 98 (by
disabling some stuffs in the or to be open-source, on the LILO boot. So I
think I can disable something in the kernel config or I can find some lines
of code in the minimal kernel to solve this problem.

But as soon the kernel begin to boot, my laptop crah (when it is cold,
powered off for a night for example), after several reboot, when it is hot,
it can be powered for a long time (1 day, 2 day sometimes) but I've still
random shutdown.

Disabling all power managment, ACPI, APM, PM at boot, CPU, Idle and "Machine
Check Exception" and now I2C still don't solve the problem. I've compiled a
new kernel without WatchDog and I'll try soon but I'm sceptic. I think
SMBALERT# is in the SMBus protocol that is a subset of I2C and this is still
not right.

So, if someone know something about the SMBALERT# signal or where in the
kernel anywhere that in the stuff exposed above could be the order to
shutdown immediately (without the proper task of a normal linux shutdown)
the laptop, any help would be appreciated.

I repeat the link from the Intel SPEC :
http://cipsa.physik.uni-freiburg.de/~zwerger/Vaio/Intel_Mobile_Temp-Prob.pdf

This previous PDF is a subset of this one :
http://cipsa.physik.uni-freiburg.de/~zwerger/Vaio/24388741.pdf

I've suspend my searches to fix it on a Windows NT, don't want to switch to
Windows 98 so it's time for me to stay on Linux and I'm sure I can find some
option or some lines of code where I can fix the stuff.

Regards,
Florent CHANTRET



> You don't even state which model you have.  Which limits my
> ability to comment.  I know i've had no problem with mine.
>
> The best things for you to do is check the specific model
> info from linux-on-laptops.com and search, then ask, on the
> linux-sony list http://returntonature.com/mailman/listinfo/linux-sony
>
> Good luck.
>
> --
> ________________________________________________________________
> J.W. Schultz            Pegasystems Technologies
> email address: jw@pegasys.ws
>
> Remember Cernan and Schmitt
>

