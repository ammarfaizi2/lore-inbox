Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266321AbRGOMJV>; Sun, 15 Jul 2001 08:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266317AbRGOMJK>; Sun, 15 Jul 2001 08:09:10 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:38411 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266306AbRGOMI4>; Sun, 15 Jul 2001 08:08:56 -0400
Date: 15 Jul 2001 13:53:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <84uhW6amw-B@khms.westfalen.de>
In-Reply-To: <3B508D34.180A07A0@mandrakesoft.com>
Subject: Re: __KERNEL__ removal
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu> <3B5083AE.71515696@mandrakesoft.com> <p05100309b77639cfaced@[207.213.214.37]> <3B508D34.180A07A0@mandrakesoft.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@mandrakesoft.com (Jeff Garzik)  wrote on 14.07.01 in <3B508D34.180A07A0@mandrakesoft.com>:

> If we want to avoid the retyping (which is IMHO the most clean
> separation for all cases, even if it involves drudgery) then separating
> out code into libc-only headers would be nice.

Not that I think anyone is going to take me up on this, judging from prior  
experience ...

... but if we are looking for a clean solution to types and constants that  
are needed to communicate between kernel and user space, IMO the thing to  
do is to define these in some sort of generic format, and have a tool to  
generate actual headers from that according to whatever kernel, libc or  
whoever wants to see. Possibly more than one tool as requirements differ.

That generic format *could* be a restricted form of C (restricted to only  
those features needed for this task), but need not be.

The tool in question is not all that difficult to write; *if* people think  
this is the right way to go (and agree on some of the necessary details),  
I could write it. In C, even, so it doesn't need extra tools.

MfG Kai
