Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWISRqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWISRqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWISRqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:46:52 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:47817 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S1030278AbWISRqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:46:51 -0400
Date: Tue, 19 Sep 2006 10:46:49 -0700
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM
Message-ID: <20060919174649.GE7845@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <200609190804.14786.ak@suse.de> <20060919062828.GD7845@chain.digitalkingdom.org> <200609190839.51123.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609190839.51123.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 08:39:51AM +0200, Andi Kleen wrote:
> On Tuesday 19 September 2006 08:28, Robin Lee Powell wrote:
> > On Tue, Sep 19, 2006 at 08:04:14AM +0200, Andi Kleen wrote:
> > > 
> > > > Done; it's at
> > > > http://teddyb.org/~rlpowell/media/regular/lkml/hacked-boot.txt
> > > > 
> > > > Note that I had to us "mce=off acpi=off pci=conf1" to get any of
> > > > that hack's output to show up at all; I wasn't clear whether you
> > > > intended that or not.
> > > 
> > > Unfortunately with mce=off we can't see which device breaks. Can
> > > you please boot with the patch and just 
> > > 
> > > acpi=off pci=conf1 ? 
> > > 
> > > and send the full output?
> > 
> > The result is a reboot in the middle of bringing up CPU#1.  No
> > output from the patch is printed.
> > 
> > I've printed it below anyways.
> 
> 
> What happens when you additionally add this patch and boot with
> the same options again? 

Here's acpi=off pci=conf1:

http://teddyb.org/~rlpowell/media/regular/lkml/hacked-boot-2-acpi-pci.txt

Here's nothing:

http://teddyb.org/~rlpowell/media/regular/lkml/hacked-boot-2-none.txt

Unfortunately, the machines that actually got as far as *displaying*
an MCE were the ones with 16GiB in them, and I could no longer
justify holding on to them just for kernel testing; as you can
imagine, they're a tad expensive.

-Robin

-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/
