Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVCISl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVCISl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVCIShM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:37:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:4544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262163AbVCISe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:34:26 -0500
Date: Wed, 9 Mar 2005 10:29:28 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309182928.GA26902@kroah.com>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <1110391244.28860.208.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110391244.28860.208.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
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

Yes, that's acceptable, I agree that Andi's statment is not ok (see the
.1 release for 2 patches that were accepted in a "simple" way because
the real fix was too complex.)

I'll go update the document with this.

thanks,

greg k-h
