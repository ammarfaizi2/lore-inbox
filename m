Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTAOCCn>; Tue, 14 Jan 2003 21:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbTAOCCn>; Tue, 14 Jan 2003 21:02:43 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:51983 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S266368AbTAOCCm>; Tue, 14 Jan 2003 21:02:42 -0500
Date: Tue, 14 Jan 2003 18:11:28 -0800
From: jw schultz <jw@pegasys.ws>
To: Florent CHANTRET <florent@chantret.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMBALERT# thermal sensor signal for Intel PII in the kernel ?
Message-ID: <20030115021128.GI21077@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Florent CHANTRET <florent@chantret.com>, linux-kernel@vger.kernel.org
References: <00e901c2bbdb$563b8b50$2680a8c0@nordnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e901c2bbdb$563b8b50$2680a8c0@nordnet.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 03:43:41PM +0100, Florent CHANTRET wrote:
> Hi geeks and guru's ;o)
> 
> But, I've a problem with my laptop Sony VAIO powered by a bugged as hell
> Intel PII Celeron (lot of customers from Sony have the same problem and
> there is no support from this fuckin' company, nor from Intel, and I don't
> think contacting Micro$$$$oft is the good thing to do).
> 
> My laptop randomly shutdown due to a bug in the thermal sensor of the PII
> sending a SMBALERT# signal. There is no solution for NT fuckin' OS (only a
> trick on "WinDaube" 98 (french expression for WinShit ;o))
> 
> Here is the Intel stuff about the bug :
> http://cipsa.physik.uni-freiburg.de/~zwerger/Vaio/Intel_Mobile_Temp-Prob.pdf
> Here is the fix on fuckin' Windows 98 (as a curiosity) :
> http://cipsa.physik.uni-freiburg.de/~zwerger/Vaio/indexeng.htm
> 
> So there is a software way to fix this hardware bug.
> 
> So I've build a 2.4.20 kernel without  all the APM,ACPI, PM at boot, CPU
> Idle and "Machine Check Exception" but I've still the problem. The kernel
> still answer to an SMBALERT# which cause the machine to shutdown.
> 
> So, before asking in the ML, I've searched on Google and Google Groups
> without success (there is quite nothing about SMBALERT#).
> 
> I've grepped all the 2.4.20 source code but there is anywhere the presence
> of SMBALERT# in a comment. I've noticed some codes about SMBus (which I
> think include the SMBALERT functionnality) but I don't know if I can
> deactivate SMBus in the kernel config and if it is safe to do it.
> 
> There is several functions in the kernel for SMBus so if I must patch the
> code to deactivate this precise signal, any help would be appreciated ;o)
> 
> If I can fix it, I will try to convert all the consumers of the F-serie VAIO
> bugged to Linux ;o)
> 
> Thanks for your answer and sorry if this is not the good place to post but
> I've searched a lot before. I don't want to erase Linux to put a "Windaube
> 98" help help help ;o)

You don't even state which model you have.  Which limits my
ability to comment.  I know i've had no problem with mine.

The best things for you to do is check the specific model
info from linux-on-laptops.com and search, then ask, on the
linux-sony list http://returntonature.com/mailman/listinfo/linux-sony

Good luck.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
