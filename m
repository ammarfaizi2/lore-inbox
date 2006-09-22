Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWIVPs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWIVPs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWIVPs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:48:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26540 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964774AbWIVPs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:48:57 -0400
Date: Fri, 22 Sep 2006 11:48:16 -0400
From: Dave Jones <davej@redhat.com>
To: David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060922154816.GA15032@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Miller <davem@davemloft.net>, jeff@garzik.org,
	davidsen@tmr.com, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922083542.GA4246@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 09:35:42AM +0100, Russell King wrote:
 > On Thu, Sep 21, 2006 at 06:05:39PM -0400, Dave Jones wrote:
 > > We already have some subsystems that do once-per-release merges,
 > > and then let fixes build up in their out-of-tree SCM for months
 > > until the next window. It won't necessarily get worse, but unless
 > > everyone is participating in the odd/even rules, we won't get
 > > the benefits that it would offer.
 > 
 > I'm heading in that direction (once-per-release merges) actually.
 > 
 > On one hand, I'm credited with the ARM architecture being one of the
 > best maintained embedded architectures in the kernel tree.  On the
 > other hand, that appears to be winding Linus up due to the regular
 > merge requests, which were happening maybe once or twice a week.

Hmm. Some trees do seem to get pulled more often than others.
Linus, is there a upper limit on the number of times you want
to see pull requests? It strikes me as odd, so I'm wondering
if there are some crossed wires here.

 > As far as -mm getting these, I have asked Andrew to pull this tree in
 > the past, but whenever I rebase the trees (eg, when 2.6.18 comes out)
 > and fix up the rejects, Andrew seems to have a hard time coping.  I
 > guess Andrew finds it too difficult to handle my devel branches.

Has Andrew commented on why this is proving to be more of a problem?
I've done regular rebases of cpufreq/agpgart (admittedly, they don't
reject hardly ever unless Len has ACPI bits touching cpufreq) without
causing too much headache.

 > So, what I'm going to be doing this cycle is essentially sitting on
 > stuff for quite some time and not really caring about where in the
 > release cycle mainline actually is. 

That doesn't sound like the right way to fix the 'caring for my Linus' problem :)

 > As far as my future, I will be handing MMC off to Pierre Ossman during
 > this cycle (there are other reasons for doing this which Pierre has been
 > aware of for some time.)
 > 
 > I'll also be dropping my serial tree entirely - I have no idea who could
 > stand in for serial, so there's going to be no real "hand over" for that.
 > I do have some outstanding in-progress changes which aren't really ready,
 > but those will probably end up in /dev/null (in much the same way that my
 > in-progress changes for PCMCIA ended up in a similar place when I handed
 > that tree over.)

That's unfortunate. If you want someone to scoop bits up and feed Linus,
I'm happy to volunteer for the task, as long as you're still willing
to eyeball serial diffs until I get up to speed.

	Dave 
