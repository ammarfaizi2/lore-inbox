Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbRCJUXJ>; Sat, 10 Mar 2001 15:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131149AbRCJUWu>; Sat, 10 Mar 2001 15:22:50 -0500
Received: from mail.zmailer.org ([194.252.70.162]:40978 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129460AbRCJUWj>;
	Sat, 10 Mar 2001 15:22:39 -0500
Date: Sat, 10 Mar 2001 22:21:46 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Blanchard <anton@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: allow notsc option for buggy cpus
Message-ID: <20010310222146.L23336@mea-ext.zmailer.org>
In-Reply-To: <20010310115828.A7514@linuxcare.com> <E14bY2D-00063q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14bY2D-00063q-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Mar 10, 2001 at 01:19:03AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2001 at 01:19:03AM +0000, Alan Cox wrote:
> > My IBM Thinkpad 600E changes between 100MHz and 400MHz depending if the
> > power is on. This means gettimeofday goes backwards if you boot with the
> Intel speedstep CPU. 
> 
> > Even so, we should really catch these cpus at run time. 
> Intel are being remarkably reluctant on the documentation front.  We have
> the AMD speed change docs, but the intel ones (chipset not cpu based
> primarily) don't seem to be publically available. In fact the 815M manual
> looks like someone quite pointedly went through and removed the relevant
> material before publication

	Isn't that one of the things that the ACPI is for ?
	Aren't we supposed to use  ACPI  for this ?

/Matti Aarnio
