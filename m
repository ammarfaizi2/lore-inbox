Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUC0Tu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 14:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUC0Tu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 14:50:29 -0500
Received: from napo.bezeqint.net ([192.115.104.9]:10923 "EHLO
	napo.bezeqint.net") by vger.kernel.org with ESMTP id S261857AbUC0Tu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 14:50:27 -0500
Date: Sat, 27 Mar 2004 21:50:09 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: swsusp-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was	Re: Your opinion on the merge?]]
Message-ID: <20040327195009.GA2737@luna.mooo.com>
Mail-Followup-To: swsusp-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <200403270337.48704.luke-jr@artcena.com> <20040327042849.GB2606@luna.mooo.com>
	 <200403270440.47737.luke-jr@artcena.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403270440.47737.luke-jr@artcena.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 04:40:47AM +0000, Luke-Jr wrote:
> On Saturday 27 March 2004 04:28 am, Micha Feigin wrote:
> > Actually it would be very unlikely that grabbing the hard disk would
> > enable to boot on another machine since you are restoring all the
> > context/modules etc. The grabber would need an identical system, and
> > even then I doubt it would work (I don't know how flexible linux and
> > the hardware are in this respect.
> But a different system *could* be used to analyze the content of the partition 
> were it stolen.

It could be relevant so that you can access the resume data only on the
same computer so that access to encrypted partitions couldn't be gained
by looking at the suspend data, but I don't know how encrypted
partitions work, so can't say anything about that.

> >
> > Its more a question of grabbing you entire computer and getting access
> > to you hard disk, including encrypted partitions. In this case you
> > would want to request a key from the user and not use a hardware
> > related key.
> hardware-related is probably better than an argument, at least.

If the key is given at resume command line and this is properly
forgotten when the resumed kernel kicks in then a user key will also
probably be ok.

It wouldn't do much good getting a safer method then the way the
encrypted partition works in the first place.

I think the difference would be user convenience more then security.

> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> swsusp-devel mailing list
> swsusp-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/swsusp-devel
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
