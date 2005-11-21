Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVKUXEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVKUXEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVKUXEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:04:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:43426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751247AbVKUXEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:04:01 -0500
Date: Mon, 21 Nov 2005 15:01:41 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051121230136.GB19212@kroah.com>
References: <20051121225303.GA19212@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121225303.GA19212@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 02:53:03PM -0800, Greg KH wrote:
> Subject: PCI: fix up the exported symbols to be the proper license.

Ok, now that I have everyone's attention, no I'm not serious about
submitting this patch, I'm not a fool.  I know the rules about existing
kernel symbols.

But, what if this patch really did go in?  Who would be affected by
this?  Nothing that is currently in the kernel.org kernel tree, right,
so what's the big deal?

Oh yeah, closed source drivers that are out side of the tree, but who
cares about them?

Oh yeah, _very_ large companies rely on them right now, and are working
on creating more and more closed source drivers.  Why?  Don't they know
that their legal departments do not agree with this?  Are they
approaching Linux development in the same way they used to with the old
Unix systems, i.e. fork and "add value"?

Well, consider this a warning shot for anyone who is relying on closed
source modules.  What you are doing is trying to take from Linux and not
give anything back..  The GPL explicitly forbids this, and Linux would
not be good enough today for you to be using it without that protection.
There is a reason why you are wanting to use Linux for your internal
use, and why your customers are asking for it.

If you, or your company is relying on closed source kernel modules, your
days are numbered.  And what are you going to do, and how are you going
to explain things to your bosses and your customers, if possibly,
something like this patch were to be accepted?

Something to think about...

thanks,

greg k-h
