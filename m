Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVLaATJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVLaATJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVLaATI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:19:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:16876 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751084AbVLaATH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:19:07 -0500
Date: Fri, 30 Dec 2005 16:13:36 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 12 of 20] ipath - misc driver support code
Message-ID: <20051231001336.GD20314@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com> <5e9b0b7876e2d570f25e.1135816291@eng-12.pathscale.com> <20051230082505.GC7438@kroah.com> <1135984209.13318.47.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135984209.13318.47.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 03:10:09PM -0800, Bryan O'Sullivan wrote:
> On Fri, 2005-12-30 at 00:25 -0800, Greg KH wrote:
> > > +	unsigned long long Control;
> > > +	unsigned long long PageAlign;
> > > +	unsigned long long PortCnt;
> > 
> > And what's with the InterCapsNamingScheme of these variables?
> 
> They're taken straight from the register names in our chip spec.  I can
> squish them to lowercase-only, if that seems important.

No, but document it that this is the reason for it (along with a pointer
to your chip spec, if possible.)

thanks,

greg k-h
