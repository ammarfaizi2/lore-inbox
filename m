Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVCITba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVCITba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVCITb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:31:27 -0500
Received: from colin2.muc.de ([193.149.48.15]:22278 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262432AbVCITam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:30:42 -0500
Date: 9 Mar 2005 20:30:34 +0100
Date: Wed, 9 Mar 2005 20:30:34 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309193033.GA17918@muc.de>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <1110391244.28860.208.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110391244.28860.208.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 06:00:45PM +0000, Alan Cox wrote:
> On Mer, 2005-03-09 at 09:56, Andi Kleen wrote:
> > - It must be accepted to mainline. 
> 
> Strongly disagree. What if the mainline fix is a rewrite of the core API
> involved. Some times you need to put in the short term fix. What must
> never happen is people accepting that fix as long term.
> 
> How about
> 
>  - It must be accepted to mainline, or the accepted mainline patch be
> deemed too complex or risky to backport and thus a simple obvious
> alternative fix applied to stable ONLY.

That is what I wrote later in my mail anyways (did you really read it completely?:)  See also the followup discussion with Russel and Arjan.

In general stable specific fixes should be the exception, not the rule though.

-Andi
