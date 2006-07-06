Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWGFJKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWGFJKE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWGFJKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:10:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:21468 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965117AbWGFJKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:10:01 -0400
Subject: Re: [PATCH] powerpc: Xserve G5 thermal control fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <CCA3F98E-8F8F-4003-87BA-8091F8AB668F@kernel.crashing.org>
References: <1152162394.24632.58.camel@localhost.localdomain>
	 <CCA3F98E-8F8F-4003-87BA-8091F8AB668F@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 19:09:47 +1000
Message-Id: <1152176987.24632.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 07:37 +0200, Segher Boessenkool wrote:
> > This patch also changes the fixed value of the slots fan for
> > desktop G5s to 40% instead of 50%. It seems to still have a pretty  
> > good
> > airflow that way and is much less noisy.
> 
> Is this save when people have one of the ridiculously expensive
> (and hot) video cards installed?  And perhaps even a few other
> cards, too?

Those cards are nvidia and they only get hot if you use the 3d which you
can't do in linux/ppc (beside they have their own fan on the card
anyway).

Ben.


