Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTKGWSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTKGWR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:17:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:21899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264518AbTKGRsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 12:48:24 -0500
Date: Fri, 7 Nov 2003 09:46:59 -0800
From: Greg KH <greg@kroah.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 Fix oops in quirk_via_bridge
Message-ID: <20031107174659.GC1546@kroah.com>
References: <3FA22E6F.8000404@metaparadigm.com> <20031031094946.A4556@flint.arm.linux.org.uk> <3FA2324F.20801@metaparadigm.com> <20031031100043.B4556@flint.arm.linux.org.uk> <3FA23B77.5040804@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA23B77.5040804@metaparadigm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 06:37:43PM +0800, Michael Clark wrote:
> On 10/31/03 18:00, Russell King wrote:
> >On Fri, Oct 31, 2003 at 05:58:39PM +0800, Michael Clark wrote:
> >
> >Your fix looks 99% correct, except for the "__devinitdata" part - if
> >you drop this and resubmit the patch, I'm sure gregkh will take it.
> 
> Cool. dropped __devinitdata, tested and works. Now I can suspend
> and resume then insert my ieee1394 cardbus controller with no oops.

Thanks, I've applied this and will send it on to Linus in a bit.

greg k-h
