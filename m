Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270447AbVBFH3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270447AbVBFH3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270613AbVBFH3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:29:22 -0500
Received: from smtpout.mac.com ([17.250.248.46]:47819 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S270447AbVBFHZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:25:50 -0500
In-Reply-To: <9e473391050205224960767ad0@mail.gmail.com>
References: <9e4733910502051745c25d6f@mail.gmail.com> <20050206040526.GA2908@redhat.com> <9e4733910502052158491b5ce3@mail.gmail.com> <20050206060839.GA19330@redhat.com> <9e473391050205224960767ad0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <48A69787-7810-11D9-82FF-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Intel AGP support attaching to wrong PCI IDs
Date: Sun, 6 Feb 2005 02:25:31 -0500
To: Jon Smirl <jonsmirl@gmail.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 06, 2005, at 01:49, Jon Smirl wrote:
> X on GL is already written and is part of the xserver project. This
> will run on the standalone OpenGL stack. Combine this with Cairo/Glitz
> and we have a graphics system that can compete with Windows Longhorn.

Why compete with vaporware (mostly)? If you really want to see a 
complete
modern graphics system, check out OS X.  See the below screenshots for
one example.

http://tjhsst.edu/~kmoffett/2k4-1.png
http://tjhsst.edu/~kmoffett/2k4-2.png

The rendered window from 2k4 has been distorted by the windowing system
post-processing using a mesh transform.  It runs just as quickly this
way as it does full screen normally, at least as far as I can tell
while playing. :-D A truely well-performing graphics system should be
able to handle multiple applications processing to generate a single
output stream without effort.  I also ran some informal and simple
end-user-style tests a while back where I rapidly switched between and
moved around the following windows (each distorted in the same way):
	1)	A UT2k4 window playing a demo
	2)	A couple translucent terminal windows continuously scrolling
		text
	3)	A DVD player window playing The Matrix
	4)	A couple Quicktime player windows with movies running

The best part was: ~60 FPS on everything, despite the distortions,
translucency, rapid movement, DVD playing, etc.  I hope that when the
new linux graphics and Soft-RT stuff is done it will be able to achieve
similar performance. If my coding skills were a little more up to
snuff, I would try to help out, but as it is, I fear I'd just muddy
the waters :-\.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


