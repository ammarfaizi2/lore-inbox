Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279462AbRKKOdX>; Sun, 11 Nov 2001 09:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281063AbRKKOdM>; Sun, 11 Nov 2001 09:33:12 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:18618 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S279462AbRKKOc7>; Sun, 11 Nov 2001 09:32:59 -0500
Date: 11 Nov 2001 12:27:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8Ce2E6lmw-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.33.0111071409530.17287-100000@sweetums.bluetronic.net>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.30.0111071212430.9535-100000@gib.soccerchix.org> <Pine.GSO.4.33.0111071409530.17287-100000@sweetums.bluetronic.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jfbeam@bluetopia.net (Ricky Beam)  wrote on 07.11.01 in <Pine.GSO.4.33.0111071409530.17287-100000@sweetums.bluetronic.net>:

> As for code maint. and kernel changes breaking things... both happen already
> with the text based system.  Binary structures can be constructed to be
> extensible without breaking old tools.  Plus, the information exported from
> the kernel (in the case of processes) need not change with every version
> of the kernel.

And the exact same thing can be done with ASCII, too - only easier.

> I don't think people realize just how many CPU cycles are being needlessly
> expended in passing information between the kernel and the user.  When I
> have the time, I'll add binary interfaces for various things and show
> exactly how expensive the existing system is -- all for the sake of being
> able to use 'cat' and 'grep'.

I consider those cycles *very* well spent. Being able to use those common  
tools is rather important to very many people.

Let's write a /proc ASCII coding rules document. It should document well a  
few (*very* few) generic formats to use for new entries, and big fat  
warnings about ever changing the format of existing tables, and it should  
be easy to find in /Documentation/ - and we should immediately jump on  
anyone who violates it without, in advance, discussing the problem he's  
trying to solve, and convincing us that they can't be solved any other  
way.

I don't much care how those formats look, as long as they're easy to parse  
and to extend compatibly, and *few*.

MfG Kai
