Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTFIQJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTFIQJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:09:05 -0400
Received: from chenas.mae.cornell.edu ([128.253.249.162]:7336 "EHLO
	chenas.mae.cornell.edu") by vger.kernel.org with ESMTP
	id S264495AbTFIQJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:09:01 -0400
Date: Mon, 9 Jun 2003 12:20:05 -0400
From: Andrey Klochko <andrey@chenas.mae.cornell.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Add module_kernel_thread for threads that live in modules.
Message-ID: <20030609151021.GA22230@chenas.mae.cornell.edu>
References: <E19NkWO-0005i0-00@notabene.cse.unsw.edu.au> <20030605105016.A9587@morgon.mae.cornell.edu> <16097.31014.94516.422433@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16097.31014.94516.422433@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for expalining that.

Andrey

On Sat, Jun 07, 2003 at 03:33:26PM +1000, Neil Brown wrote:
> On Thursday June 5, andrey@morgon.mae.cornell.edu wrote:
> > >  
> > > -	/* Release module */
> > > -	unlock_kernel();
> > 
> > You've locked the kernel and didn't unlock it.
> >  
> 
> This was just before the thread exited.  When a thread exits it
> automatically drops the kernel lock anyway.  It seemed un-necessary to
> explicitly unlock it aswell.
> 
> NeilBrown

-- 
-------------------------------------------------------------
Andrey Klochko
System Administrator
Sibley School of Mechanical and Aerospace Engineering
288 Grumman Hall
Cornell University
Ithaca, NY 14853

e-mail: andrey@mae.cornell.edu
phone: 607-255-0360
