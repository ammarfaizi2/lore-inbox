Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUCBT1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 14:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUCBT1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 14:27:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:17895 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261747AbUCBT1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 14:27:30 -0500
Date: Tue, 2 Mar 2004 11:26:33 -0800
From: Greg KH <greg@kroah.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Jens Axboe <axboe@suse.de>,
       Daniel Robbins <drobbins@gentoo.org>, linux-kernel@vger.kernel.org,
       Mike@kordik.net, kpfleming@backtobasicsmgmt.com
Subject: Re: [PATCH] Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
Message-ID: <20040302192631.GA2820@kroah.com>
References: <1077933682.14653.23.camel@wave.gentoo.org> <20040228021040.GA14836@kroah.com> <20040229095139.GH3149@suse.de> <20040301074348.GA7646@ip68-4-255-84.oc.oc.cox.net> <40448799.5030508@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40448799.5030508@grupopie.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 01:09:45PM +0000, Paulo Marques wrote:
> Barry K. Nathan wrote:
> 
> > 
> >+		/* We must increment writecount here, and not at the
> >+		 * end of the loop. Otherwise, the final loop iteration may
> >+		 * be skipped, leading to incomplete printer output.
> >+		 */
> 
> 
> You are correct.
> 
> 
> I'm affraid this is my fault, for correcting a bug and letting another one 
> take its place :(
> 
> It seems that this patch squashes them both. It should go in ASAP.

This patch is already in Linus's tree.

thanks,

greg k-h
