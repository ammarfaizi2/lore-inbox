Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWCIUQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWCIUQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWCIUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:16:44 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:57307 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751352AbWCIUQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:16:44 -0500
Message-ID: <44108CCB.9080709@cfl.rr.com>
Date: Thu, 09 Mar 2006 15:15:07 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Dave Neuer <mr.fred.smoothie@pobox.com>
CC: Luke-Jr <luke@dashjr.org>, Anshuman Gholap <anshu.pg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>  <200603091509.06173.luke@dashjr.org> <441057D4.6030304@cfl.rr.com> <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com>
In-Reply-To: <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Mar 2006 20:19:05.0244 (UTC) FILETIME=[B68CFDC0:01C643B6]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14314.000
X-TM-AS-Result: No--7.800000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Neuer wrote:
>> Interacting with the kernel does not make your software a derived work.
> 
> That may or may not be true, depending on the nature of the
> interaction, and the arbiter of truth in this case is the court
> system, not you or I.
> 

That is correct, the final decision is up to a Judge, but we aren't in 
court here, we're discussing it, and so I'm making an argument that I 
believe any sane judge would side with.

> There are no dearth of legal opinions on this matter which differ
> quite radically from your interpretation here, quite a few from
> lawyers. As far as I am concerned (and the GPL too, if my
> interpretation of it is correct), any code is a derived work of my
> code if either a) it directly makes use of symbols in my code or b) it
> cannot execute unless my code executes, such that its distribution
> without my code would be useless.
> 

As you said above, your opinion doesn't matter, only the law and a 
judge's interpretation of it, and the law says no such thing.  Take a 
look at USC Title 17 Chapter 1 Section 101:

A “derivative work” is a work based upon one or more preexisting works, 
such as a translation, musical arrangement, dramatization, 
fictionalization, motion picture version, sound recording, art 
reproduction, abridgment, condensation, or any other form in which a 
work may be recast, transformed, or adapted. A work consisting of 
editorial revisions, annotations, elaborations, or other modifications, 
which, as a whole, represent an original work of authorship, is a 
“derivative work”.

No mention of either of your two conditions.  You _might_ be able to 
argue that they use your headers to compile their driver, so that 
violates your copyright, but they are free to develop their own 
compatible headers to produce compatible binaries which are in no way 
derived from the Linux kernel.  See Wine's win32 compatible headers and 
libraries for examples of this.


>> This is why it is legal to reverse engineer a binary driver to gain an
>> understanding of how the hardware operates, publish that information,
>> and then use that information to create new software to operate that
>> hardware.
> 
> No, you are referring to a restriction on the limitations in software
> licenses which is separate from copyright. Copyright law does not talk
> about interoperability at all. And even the applicability of the
> restriction to which you refer is jurisdiction-dependant as well as
> context-dependant (see the DMCA).
> 

No, licenses do not enter the picture at all, I am referring to the Fair 
Use clause of the copyright act and the body of precedence built on it. 
Title 17 specifically states that the study of a copyright work falls 
under fair use and therefore, is not an infringement.  Reverse 
engineering is a form of study, and thus is protected as fair use.

Copyright does not apply to a _process_ ( that's patents ), only to the 
particular expression, therefore, it has been well established in the 
courts that it is not infringing to create a new unique expression that 
serves the same purpose and engages in the same process.  This is why it 
is legal to reverse engineer a windows binary only driver to figure out 
the hardware interface, and write your own driver for linux.


