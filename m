Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTHSWk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTHSWk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:40:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:26545 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261292AbTHSWky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:40:54 -0400
Date: Tue, 19 Aug 2003 14:43:14 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't read fan-speeds from i2c
Message-ID: <20030819214314.GA6362@kroah.com>
References: <1061324213.708.6.camel@chevrolet.hybel> <20030819205356.GA5968@kroah.com> <1061326633.611.8.camel@chevrolet.hybel> <20030819210223.GB6170@kroah.com> <1061328876.611.31.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061328876.611.31.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 11:34:36PM +0200, Stian Jordet wrote:
> tir, 19.08.2003 kl. 23.02 skrev Greg KH:
> > On Tue, Aug 19, 2003 at 10:57:13PM +0200, Stian Jordet wrote:
> > > tir, 19.08.2003 kl. 22.53 skrev Greg KH:
> > > > On Tue, Aug 19, 2003 at 10:16:53PM +0200, Stian Jordet wrote:
> > > > > Hi,
> > > > > 
> > > > > I have a Asus CUV266-DLS, which uses the as99127f chipset. Everything
> > > > > seems to work as it is supposed to, except for fan-speeds. They say 0.
> > > > > Is that supposed behaviour since the as99127f doesn't have any
> > > > > datasheets, or am I doing something wrong?
> > > > 
> > > > What kernel version are you using?
> > > 
> > > Latest bk-snapshot...
> > 
> > Does 2.4 work just fine for this chip and driver and 2.6 does not?  If
> > 2.4 also doesn't work, I would suggest bringing this up on the sensors
> > mailing list.
> 
> Doesn't work with 2.4 neither. I'll try the list, but I don't have much
> hope for them doing anything. Quoting from the their webpage:
> 
> If you have problems, please lobby Asus to release a datasheet.
> Unfortunately several others have without success.
> Please do not send mail to us asking for better as99127f support.
> 
> Which I do ofcourse understand. I just wondered if there was some voodoo
> I didnt' understand. Works fine with Motherboard Monitor 5 in Windows.

Ah, then it isn't a 2.6 issue, so I'm happy :)

Good luck trying to get a spec sheet from them.

greg k-h
