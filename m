Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVBAMnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVBAMnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 07:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVBAMnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 07:43:15 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:8047 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262005AbVBAMnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 07:43:05 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,169,1102287600"; 
   d="scan'208"; a="2849353:sNHT21501504"
To: linux-kernel@vger.kernel.org
Subject: [x86_64] SATA disks on ICH5 not detected in 2.6.{8,9}
Organization: Fujitsu Siemens Computers VP BC E SW OS
From: Rainer Koenig <Rainer.Koenig@fujitsu-siemens.com>
Date: Tue, 01 Feb 2005 13:43:01 +0100
Message-ID: <87u0owqwmi.fsf@ABG3595C.abg.fsc.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope my follwing questions are not too much offtopic on the LKML.

I just filed this bug: http://bugzilla.kernel.org/show_bug.cgi?id=4142

Its about problems with SATA support on x86_64 architecture. And yes, it
looks like the bug is solved (either on purpose or accidentialy) in 2.6.10.
But I'm still a bit concerned, because the impact of the problem is rather
deep: This bug prevents people from installing Linux on their machines if
they have an AMD64/EM64T architecture and if they have only SATA disks.
So if someone buys an actual high end system for a lot of bucks and gets
an actual distribution to install on it he's stuck because the install
kernels don't have the capability to recognize the SATA disks in the 
machine.

Looking at the bug-trackers of different distributions and also the 
kernel bug tracker I have the impression that a lot of people are 
suffering from such a bug. Here in my workplace I'm suffering as well,
because we produce machines and tell our customers "yes, it runs with
Linux" based on e.g. a distribution that was working with an earlier
kernel that didn't have this bug. Ok, shit happens, I know, but
I wonder, if there is something that we can do about that. 

One thing that is coming to my mind is: How do distibutors select 
the kernel they use for their distribution. And: Is there a chance
to submit bug alerts to distributors with a recommondation like
"Don't use kernel x.y.z because it has problems in detecting well
known hardware"? I guess, the impact of such a problem doesn't only
hit PC hardware vendors, a distributor will get a lot of annoyed
customers if the distribution is not installable on some sort of 
hardware. 

Can I offer some help as well? Ok, I'm far away from being a kernel
hacker, but at least I have access to actual and brand new hardware
here in my laboratory. So I wonder if I can find the resources (time,
hardware and people) to do a sort of "regresion tests" on this hardware
(especially thinking on AMD64/EM64T architecture) every time a new
kernel is released. Actually I'm buried under a workload that is 
increasing faster than I can handle it :-) but I have the hope that
my employer soon agrees to hire some students that will come to 
support me. And seeing the trouble that such a bug causes when its
detected at a customer (and not before in any testing environment)
makes me think that there much sense in using part of my ressources
for testing of new kernels. 

Thanks for reading this, comments are welcome. 
Rainer
P.S.: I'm not subscribed to the LKML, but I read it via the NNTP 
gateway. 
-- 
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux
Fujitsu Siemens Computers 
VP BC E SW OS
Phone: +49-821-804-3321
Fax:   +49-821-804-2131
 
