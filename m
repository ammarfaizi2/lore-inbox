Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWBLME4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWBLME4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 07:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWBLME4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 07:04:56 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:12042 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932395AbWBLME4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 07:04:56 -0500
Date: Sun, 12 Feb 2006 13:04:51 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060212120450.GA93069@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210235654.GA22512@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 03:56:54PM -0800, Greg KH wrote:
> On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> > 
> > The kernel could provide a list of devices by category. It doesn't have 
> > to name them, run scripts, give descriptions, or paint them blue. Just a 
> > list of all block devices, tapes, by major/minor and category (ie. 
> > block, optical, floppy) would give the application layer a chance to do 
> > it's own interpretation.
> 
> It does so today in sysfs, that is what it is there for.

Except it does not provide the path to the device nodes themselves.
You need to call udevinfo for that, or parse /dev/.udev/*.  Do you
think it would be possible to have hotplug/udev/whatever exists in the
future to give that information back in the kernel and have it appear
in sysfs?

  OG.

