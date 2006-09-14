Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWINGOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWINGOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 02:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWINGOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 02:14:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:23964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751358AbWINGOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 02:14:35 -0400
Date: Wed, 13 Sep 2006 22:55:29 -0700
From: Greg KH <greg@kroah.com>
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: OpPoint summary
Message-ID: <20060914055529.GA18031@kroah.com>
References: <20060911082025.GD1898@elf.ucw.cz> <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com> <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com> <20060912033700.GD27397@kroah.com> <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 04:50:43PM -0700, David Singleton wrote:
> Greg,
>   here's a few paragraphs about the power management code I'm working on.
> The OpPoint patch set is a fully functionaly power management solution,
> from kernel operating state support to userland power manager.

Thanks for the summary, but it was a bit longer than just "one
paragraph" :)

> OpPoint constructs operating points for all supported frequency, voltage
> and suspend states for PC and SoC solutions running Linux.  OpPoint
> does not break or replace cpufreq.  It leverages cpufreq code to provide
> the same driver scaling functions when cpu frequency changes affect drivers.

So it works with cpufreq?  That's a good thing, as it is a requirement.
We can't just break current usages.

> OpPoint is a fully functional solution ready for testing and evaluation
> in Andrew's or your tree.
> 
> The kernel patches are available at:
> 
>        http://source.mvista.com/~dsingleton/2.6.1-rc6

I get a 404 with that link :(

Care to resend your patches in the proper format, through email so that
we can see them, and possibly get some testing in -mm if they look sane?

thanks,

greg k-h
