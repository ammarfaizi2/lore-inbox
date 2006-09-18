Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWIRS7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWIRS7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWIRS7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:59:45 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:28057 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S932227AbWIRS7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:59:44 -0400
Date: Mon, 18 Sep 2006 11:59:38 -0700
To: Andi Kleen <ak@suse.de>
Cc: Bharath Ramesh <krosswindz@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060918185938.GD4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <20060914190548.GI4610@chain.digitalkingdom.org> <1158261249.7948.111.camel@mindpipe> <20060914191555.GJ4610@chain.digitalkingdom.org> <c775eb9b0609142242r45d184d2h8d7edd7dd5bc2a26@mail.gmail.com> <p737j01628d.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p737j01628d.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 09:52:18AM +0200, Andi Kleen wrote:
> "Bharath Ramesh" <krosswindz@gmail.com> writes:
> 
> > Have you tried booting newer kernel post 2.6.13 with the boot
> > option mce=bootlog and see if it goes past the current failure.
> > Try the same with with noacpi.
> 
> Did you mean mce=off? mce=bootlog will just log the leftover MCEs
> from the previous boot, but that shouldn't change anything.

mce=off allows some of the kernels with this problem (those that get
as far as an MCE) to boot.  The ones with less than 16GiB of RAM
never get an MCE, though.

-Robin

-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/
