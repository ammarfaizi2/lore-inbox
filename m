Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289324AbSAVOvg>; Tue, 22 Jan 2002 09:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289327AbSAVOv1>; Tue, 22 Jan 2002 09:51:27 -0500
Received: from gw.wmich.edu ([141.218.1.100]:5871 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S289324AbSAVOvV>;
	Tue, 22 Jan 2002 09:51:21 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: "Halpaap, Mark (CETA)" <Mark.MH.Halpaap@Dresdner-Bank.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <B575BF98FA79D4119BD20008C7A4516502E1C488@ffz00za9.wwz1me.mail.dresdner.net>
In-Reply-To: <B575BF98FA79D4119BD20008C7A4516502E1C488@ffz00za9.wwz1me.mail.dresdner.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 09:51:12 -0500
Message-Id: <1011711077.10474.3.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 09:12, Halpaap, Mark (CETA) wrote:
> Hi,
> 
> after applying mem=nopentium as a boot parameter
> I've been able to play tuxracer _for the first time_.
> 
> Prior to this any OpenGL application deepfroze
> the system after 10-20 secs.
> 
> Tried some other Loki-Demos, they run just fine
> now.
> 
> I do _not_ have an NVidia card, it's a Matrox G450.
> 
> I wasn't able to use OpenGL on both Athlon-systems
> I used (was Athlon 600 w/ G400, is a Thunderbird 1333 
> w/ G450 now), been trying it ever since XFree86 4.0 and
> with (almost) any kernel that was released since then
> (It's 2.4.16-pre1 right now).
> 
> So whatever the deeper reason, there _is_ something
> fishy that this workaround seems to fix and it seems
> not to be tied to NVidia drivers.
> 
> Mark.

I've had two different kinds of athlon's (K7-2 and Tbird 1.33Ghz) with
V3 agp and Matrox G450 agp but both of the times it was on Abit
motherboards and I have never ever experienced these problems.   I have
agpgart enabled and X set to use agp4x on my G450 and still no problems
at all with GL apps.   I've used different kernels (mostly dev) and been
using X 3.x to cvs on them.  No GL problems ever related to a boot
flag.  

I dont deny the existance of the "bug" in linux but it's just strange
how a cpu bug is turning up with some people and not others.   Perhaps
only some chips from all the batches are affected?  whatever the case
tuxracer works perfectly here.  

