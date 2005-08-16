Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVHPXXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVHPXXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVHPXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:23:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:5543 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750731AbVHPXXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:23:52 -0400
Date: Tue, 16 Aug 2005 16:23:30 -0700
From: Greg KH <greg@kroah.com>
To: Michael_E_Brown@Dell.com
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       Douglas_Warzecha@Dell.com, Matt_Domsch@Dell.com
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816232330.GA30540@kroah.com>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com> <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com> <1124161828.10755.87.camel@soltek.michaels-house.net> <20050816081622.GA22625@kroah.com> <1124199265.10755.310.camel@soltek.michaels-house.net> <20050816203706.GA27198@kroah.com> <4277B1B44843BA48B0173B5B0A0DED43528192@ausx3mps301.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4277B1B44843BA48B0173B5B0A0DED43528192@ausx3mps301.aus.amer.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 06:11:13PM -0500, Michael_E_Brown@Dell.com wrote:
> 
>     The main use of this driver by libsmbios will be to set BIOS F2 
> options. Based on your feedback, I will _NOT_ be implementing any 
> fan/sensor functionality in libsmbios, but will work with the lmsensors 
> guys to do this instead. I only originally mentioned it because I 
> thought it would be useful. My eyes have now been opened as to the best 
> way to do this, and we will do it that way.

Ok, sounds good.

Hm, what about my code comments, they seem to have been lost in the
noise...

> And just to re-iterate one more time, we can already directly hook into 
> hardware from userspace without any kernel auditing. We are just trying 
> to set this out on the table for everybody to see.

So, this whole driver is not needed at all?  It can all be done from
userspace?  If so, then this shouldn't be added to the kernel tree.

thanks,

greg k-h
