Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWBJX5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWBJX5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWBJX5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:57:11 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:2789 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932254AbWBJX5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:57:09 -0500
Date: Fri, 10 Feb 2006 15:56:54 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210235654.GA22512@kroah.com>
References: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ED005F.5060804@tmr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> 
> The kernel could provide a list of devices by category. It doesn't have 
> to name them, run scripts, give descriptions, or paint them blue. Just a 
> list of all block devices, tapes, by major/minor and category (ie. 
> block, optical, floppy) would give the application layer a chance to do 
> it's own interpretation.

It does so today in sysfs, that is what it is there for.

thanks,

greg k-h
