Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbVLRNo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbVLRNo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 08:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVLRNo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 08:44:58 -0500
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:43154
	"EHLO sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S965112AbVLRNo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 08:44:57 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: 7eggert@gmx.de, Andi Kleen <ak@suse.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <5k8PZ-4xt-9@gated-at.bofh.it> <5k9sD-5yh-13@gated-at.bofh.it>
	<5knFp-kU-51@gated-at.bofh.it> <5korL-1xX-33@gated-at.bofh.it>
	<5kpRh-3sK-11@gated-at.bofh.it> <5kq0L-3FB-37@gated-at.bofh.it>
	<5kOma-4K1-23@gated-at.bofh.it> <5kRk3-xO-11@gated-at.bofh.it>
	<E1EnrYH-00019M-Ep@be1.lrz> <20051218122818.GB23349@stusta.de>
From: Michael Poole <mdpoole@troilus.org>
Date: 18 Dec 2005 08:44:56 -0500
In-Reply-To: <20051218122818.GB23349@stusta.de>
Message-ID: <87k6e2ldt3.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:

> On Sun, Dec 18, 2005 at 06:57:44AM +0100, Bodo Eggert wrote:
> > 
> > Would you run a desktop with an nfs server on xfs on lvm on dm on SCSI?
> > Or a productive server on -mm?
> > 
> > IMO it's OK to push 4K stacks in -mm, but one week of no error reports from
> > a few testers don't make a reliable system.
> > [...]
> 
> It isn't that 4k stacks were completely untested.
> 
> Fedore enables it for a long time.
> 
> Even RHEL4 always uses 4k stacks - and RHEL is a distribution many 
> people use on their production servers.

As was pointed out previously in this thread, at least one
configuration that is known to have problems with 4k stacks is simply
not supported by RHEL.  How many more are like that?

Michael Poole
