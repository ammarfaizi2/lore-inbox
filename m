Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422848AbWBNWcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWBNWcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWBNWcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:32:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:29901 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422843AbWBNWcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:32:02 -0500
Date: Tue, 14 Feb 2006 14:30:01 -0800
From: Greg KH <greg@kroah.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, davidsen@tmr.com,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214223001.GB357@kroah.com>
References: <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix> <43F1BE96.nailMY212M61V@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F1BE96.nailMY212M61V@burner>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 12:27:18PM +0100, Joerg Schilling wrote:
> 
> Please send me the whitepaper that was used to define the interfaces
> and functionality of the /sys device

I was not aware that there is now a rule that we must write whitepapers
describing as to what the interface looks like in complete detail that
we want to add to the Linux kernel.  Will you please point me to the
proper authorities that will be enforcing this newly created rule?

> Please send me the other documentation (e.g. man pages) on the /sys
> device

What "/sys device"?  sysfs is a file system, and there have been many
magazine articles, and conference papers written, and talks given on the
topic.

If you have specific questions as to how it is structured, please let
the current sysfs maintainer know.

> Please send me a statement on how long this interface will be maintained
> inside Linux without breaking interfaces.

It will be stable and maintained until a major program depends on its
structure.  Then it will change in new and interesting ways and break
everything :)

Seriously, it isn't going away, and new information is being added all
the time to it.  Due to the structure of sysfs, changes in it is very
easy to accomidate.

thanks,

greg k-h
