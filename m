Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTDWQJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbTDWQJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:09:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:49841 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264108AbTDWQJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:09:05 -0400
Date: Wed, 23 Apr 2003 09:23:11 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       andmike@us.ibm.com
Subject: Re: [RFC] Device class rework [0/5]
Message-ID: <20030423162311.GB11175@kroah.com>
References: <20030422205545.GA4701@kroah.com> <172940000.1051059583@w-hlinder> <20030423015454.GA6298@kroah.com> <41570000.1051114688@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41570000.1051114688@w-hlinder>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 09:18:08AM -0700, Hanna Linder wrote:
> --On Tuesday, April 22, 2003 06:54:54 PM -0700 Greg KH <greg@kroah.com> wrote:
> 
> >> I did a quick sanity test of these patches on a 2-way PIII.
> >> It built and booted fine for me. I don't have any devices that 
> >> span multiple classes but the patch hasnt changed any of my 
> >> existing /sys/class output.
> > 
> > Hm, are you sure you applied them and are using that kernel?  :)
> > 
> 
> Yes. I did apply the patches... Just not to the kernel I booted ;(
> 
> Here is the correct tree I see on my 2xPIII:
> 
> 
> /sys/class
> |-- cpu
> |   |-- cpu0
> |   |   `-- device -> ../../../devices/sys/cpu0
> |   `-- cpu1
> |       `-- device -> ../../../devices/sys/cpu1

Looks good.  That "foo" file in the example I posted was from an older
kernel version on one of my boxes.  This is the correct information.

Thanks for testing,

greg k-h
