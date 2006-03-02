Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWCBQrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWCBQrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWCBQrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:47:52 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:9197 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751200AbWCBQrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:47:51 -0500
Date: Thu, 2 Mar 2006 08:47:45 -0800
From: Greg KH <greg@kroah.com>
To: Ren? Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-ID: <20060302164745.GB31076@kroah.com>
References: <200603012116.25869.rene@exactcode.de> <200603012242.35633.rene@exactcode.de> <20060301215423.GA17825@kroah.com> <200603021004.21232.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021004.21232.rene@exactcode.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 10:04:21AM +0100, Ren? Rebe wrote:
> Hi,
> 
> On Wednesday 01 March 2006 22:54, Greg KH wrote:
> 
> > > > Why not just send down 2 urbs with that size then, that would keep the
> > > > pipe quite full.
> > > 
> > > Because that requires even more modifications to libusb and sane (i_usb) ...
> > 
> > No, do it in your application I mean.
> 
> ? The driver is a SANE backend and forced to use sanei_usb over libusb. Thus
> I have to modifiy them all to allow asynchon URB queuing - or have I missed
> something?

I really don't know the SANE backend design, sorry.

greg k-h
