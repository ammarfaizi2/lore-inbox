Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbTAGXZ2>; Tue, 7 Jan 2003 18:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTAGXZ2>; Tue, 7 Jan 2003 18:25:28 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:43023 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267552AbTAGXZ1>; Tue, 7 Jan 2003 18:25:27 -0500
Date: Wed, 8 Jan 2003 00:33:58 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Honest does not pay here ...
Message-ID: <20030107233358.GC24664@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030107012429.GA12944@merlin.emma.line.org> <Pine.LNX.3.96.1030107112114.15952B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030107112114.15952B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2003, Bill Davidsen wrote:

> For Linux, there are not only dozens of kernel versions around, but the
> uni and smp versions are not the same. Vendors who want to provide drivers
> really want to provide the binary even if the module is open source, just
> because the average person has no desire to build any part of a kernel.

That's sad but true. Would there be a way to have universal interfaces
that are always the same? I mean, I'd think that if all SMP stuff is
conditionally compiled and optimized to nothing on a UP kernel that only
has the do-nothing stubs (yes, it costs overhead), but if it cuts the
maintenance workload down to half its former size, it'd be worth it.

> So it is possible to release a driver and claim in good faith that it
> works, and still not have it work with *your* system. Not because the
> vendor is evil, incompetent, a "crook" (your term), dishonest, or even
> that testing was poor, but because all kernels are very much not created
> equal. 

Well, if someone claims "Linux driver coming soon" and that driver gets
never released, that'd qualify for the harsh term. If it claims Linux
support but the performance is not on par with other OSs or similar
hardware, that's no support either.

> Try to understand why vendors want to ship binary modules and why they
> don't always work before making accusations.

Binary drivers can still be OpenSource, if they just ship with the
source. Binary-only is the problem, and that is what I was referring to.
Please excuse my causing misunderstandings.

> All that said, an independent testing service would be of use to the
> vendors, because they could find things before shipping and have someone
> to share the blame if the module didn't work with another kernel.

Indeed.
