Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284538AbRLERnw>; Wed, 5 Dec 2001 12:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284536AbRLERnn>; Wed, 5 Dec 2001 12:43:43 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:20667 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284535AbRLERne>; Wed, 5 Dec 2001 12:43:34 -0500
Date: Wed, 05 Dec 2001 09:43:12 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: RE: Over 4-way systems considered harmful :-)
Message-ID: <2523045146.1007545392@mbligh.des.sequent.com>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBMEPLECAA.znmeb@aracnet.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see how this is a win for me. And it is a win for IBM only if it
> gives them some advantage in serving their customers. I can certainly
> *conceive* of workloads bursty enough to justify an 8-processor server, but
> do they exist in the real world? And if they do, is a single 8-processor
> server better than a pair of 4-processor servers when you take graceful
> handling of faults into account? IBM has been building high-availability
> systems for *decades*, preferring to field *slightly* slower but
> *significantly* more reliable gear, which, legend has it, no one has ever
> been fired for purchasing. :-)

We (Sequent, now bought by IBM) sold 64 processor servers to people 
who needed them (the main market was large databases) so, yes, there 
is definitely a market for larger systems. It's cheaper to build a big processor 
farm out of a Beowulf style cluster, but it's not always easy / possible to 
split up your application over something like that. If you're generating 
fractals, it's easy, for other applications, it's not.
 
> Perhaps effort should be placed into software development processes and
> tools that deny race conditions the right to be born, rather than depending
> on testing on a 16-processor system to find them expeditiously :-). And

I wish you good fortune, sir. When you've acheived that, come back and
tell me, and we'll stop testing stuff ;-) It's always better to not code bugs in
the first place, but that's not the world we live in ...

> there is a whole discipline of software performance engineering to build
> performance in from the start. Advances like that would be a *huge* win for
> the Linux community, given our (relative) freedom from corporate-world
> limitations like deadlines, sales quotas, programmer salaries, and
> full-color brochures.

I'm all for encouraging good programming practices. In a way that's actually
harder in the diverse Linux community with hundreds, nay, thousands of
engineers putting code in. But we should still try - keeping the infrastructure
simple helps, for example. Trying to bug fix badly designed / written code is 
pissing into the wind.

M.

