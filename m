Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUC0E3C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 23:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUC0E3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 23:29:02 -0500
Received: from marco.bezeqint.net ([192.115.104.4]:44691 "EHLO
	marco.bezeqint.net") by vger.kernel.org with ESMTP id S262064AbUC0E27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 23:28:59 -0500
Date: Sat, 27 Mar 2004 06:28:49 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: swsusp-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was	Re: Your opinion on the merge?]]
Message-ID: <20040327042849.GB2606@luna.mooo.com>
Mail-Followup-To: swsusp-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <20040326222234.GE9491@elf.ucw.cz> <1080353285.9264.3.camel@calvin.wpcb.org.au>
	 <200403270337.48704.luke-jr@artcena.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403270337.48704.luke-jr@artcena.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 03:37:48AM +0000, Luke-Jr wrote:
> On Saturday 27 March 2004 02:08 am, Nigel Cunningham wrote:
> > On Sat, 2004-03-27 at 10:22, Pavel Machek wrote:
> > > You are right, that would be ugly. How is encryption supposed to work,
> > > kernel asks you to type in a key?
> >
> > I haven't thought about the specifics there. Perhaps the plugin prompts
> > for one, or perhaps it takes a lilo parameter? 
> The only purpose I can think of for encryption would be so someone can't grab 
> the HD and boot it on another PC or read the image directly.
> Unless I'm missing something, that would imply that the key would need to be 
> generated from a hardware profile (only creatable by root) somehow to 
> restrict its readability to that one system.
> 

Actually it would be very unlikely that grabbing the hard disk would
enable to boot on another machine since you are restoring all the
context/modules etc. The grabber would need an identical system, and
even then I doubt it would work (I don't know how flexible linux and
the hardware are in this respect.

Its more a question of grabbing you entire computer and getting access
to you hard disk, including encrypted partitions. In this case you
would want to request a key from the user and not use a hardware
related key.

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
