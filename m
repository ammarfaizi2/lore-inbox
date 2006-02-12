Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWBLTXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWBLTXb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWBLTXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:23:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:50383 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751427AbWBLTXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:23:31 -0500
Date: Sun, 12 Feb 2006 08:46:33 -0800
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060212164633.GA2941@kroah.com>
References: <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <20060212120450.GA93069@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212120450.GA93069@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 01:04:51PM +0100, Olivier Galibert wrote:
> On Fri, Feb 10, 2006 at 03:56:54PM -0800, Greg KH wrote:
> > On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> > > 
> > > The kernel could provide a list of devices by category. It doesn't have 
> > > to name them, run scripts, give descriptions, or paint them blue. Just a 
> > > list of all block devices, tapes, by major/minor and category (ie. 
> > > block, optical, floppy) would give the application layer a chance to do 
> > > it's own interpretation.
> > 
> > It does so today in sysfs, that is what it is there for.
> 
> Except it does not provide the path to the device nodes themselves.

That is not what Bill asked for.  So there is no "except" here :)

> You need to call udevinfo for that, or parse /dev/.udev/*.  Do you
> think it would be possible to have hotplug/udev/whatever exists in the
> future to give that information back in the kernel and have it appear
> in sysfs?

No.  Why would it when it is very simple to query udevinfo for that?

thanks,

greg k-h
