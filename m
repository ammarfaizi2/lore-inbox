Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271696AbTGRCVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271694AbTGRCUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:20:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:50360 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271693AbTGRCT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:19:29 -0400
Date: Thu, 17 Jul 2003 19:33:51 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: sensors@stimpy.netroedge.com, frodol@dds.nl, linux-kernel@vger.kernel.org,
       phil@netroedge.com
Subject: Re: 2.6.0-t1: i2c+sensors still whacky
Message-ID: <20030718023350.GA5902@kroah.com>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com> <20030716062922.GA1000@zip.com.au> <20030716073135.GA5338@kroah.com> <20030716224718.GA4612@zip.com.au> <20030716225452.GA3419@kroah.com> <20030717153348.GO4612@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717153348.GO4612@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 01:33:48AM +1000, CaT wrote:
> On Wed, Jul 16, 2003 at 03:54:52PM -0700, Greg KH wrote:
> > On Thu, Jul 17, 2003 at 08:47:18AM +1000, CaT wrote:
> > > On Wed, Jul 16, 2003 at 12:31:35AM -0700, Greg KH wrote:
> > > > Then just load the i2c_piix4 module.  If things still work just fine,
> > > > then try the i2c-adm1021 driver.  See what the kernel log says then.
> > > 
> > > All went well till the last step of loading the adm1021 driver.
> > 
> > And you are sure you have this hardware device?  Is that what the
> 
> Yes. I am very definate that this worked in past 2.5 kernels. Remember
> how it used to turn my laptop off under load? I was able to read my
> temps and stuff though.
> 
> > sensors package for 2.4 uses?  And 2.4 works just fine, right?
> 
> I don't use 2.4. Haven't for ages.

I would _really_ encourage you to try this, and run the sensors_detect
program to have the scripts tell you what hardware you really have, and
see if the 2.4 drivers work properly for you.

Without that, I don't know how to debug the 2.5 problem.

Let us know how that works out.

thanks,

greg k-h
