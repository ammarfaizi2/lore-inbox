Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263391AbRFFOmK>; Wed, 6 Jun 2001 10:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbRFFOlu>; Wed, 6 Jun 2001 10:41:50 -0400
Received: from step.polymtl.ca ([132.207.4.32]:661 "EHLO step.polymtl.ca")
	by vger.kernel.org with ESMTP id <S263344AbRFFOlm>;
	Wed, 6 Jun 2001 10:41:42 -0400
Date: Wed, 6 Jun 2001 10:41:25 -0400
From: Marc Heckmann <pfeif@step.polymtl.ca>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
        Derek Glidden <dglidden@illusionary.com>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606104125.A20457@step.polymtl.ca>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com> <3B1D927E.1B2EBE76@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1D927E.1B2EBE76@uow.edu.au>; from andrewm@uow.edu.au on Wed, Jun 06, 2001 at 12:16:30PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 12:16:30PM +1000, Andrew Morton wrote:
> "Jeffrey W. Baker" wrote:
> > 
> > Because the 2.4 VM is so broken, and
> > because my machines are frequently deeply swapped,
> 
> The swapoff algorithms in 2.2 and 2.4 are basically identical.
> The problem *appears* worse in 2.4 because it uses lots
> more swap.

exactly, I've seen this on a 2.2.16 box that went deep into swap. Although
it didn't lock up, kswapd was using most of the CPU time during a swapoff.
   
        -mh
