Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVFRWwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVFRWwm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVFRWwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:52:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58825 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262194AbVFRWwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:52:40 -0400
Date: Sun, 19 Jun 2005 00:52:38 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: David L <idht4n@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bad: scheduling while atomic!: how bad?
Message-ID: <20050618225238.GB23688@devserv.devel.redhat.com>
References: <1119132601.5871.22.camel@localhost.localdomain> <BAY104-F22EC810AC3D3079BA9BB2D84F70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY104-F22EC810AC3D3079BA9BB2D84F70@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 03:49:33PM -0700, David L wrote:
> [snip]
> >On Sat, 2005-06-18 at 14:59 -0700, David L wrote:
> >> I'm seeing the message:
> >>
> >> bad: scheduling while atomic!
> >>
> >> I see this dozens of times when I'm writing to a nand flash device using 
> >a
> >> vendor-provided driver from Compulab in 2.6.8.1.  Does this mean the 
> >driver
> >> has a bug or is incompatible with the preemptive configuration option?  
> >How
> >> bad is "bad"?  Should I turn of the preemption option, ignore the 
> >message,
> >> or what?
> >
> >can you post the sourcecode of the driver? it needs fixing...
> It's on-line at:
> 
> http://www.compulab.co.il/686-developer.htm
> 
> under "Linux - kernel, drivers and patches".
> 
> After unzipping, it's in:
> 
> Drivers & Patches 2.6/Flash Disk/cl_fdrv.tgz

that's only part of the source though... can you point at the full one ?
