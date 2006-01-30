Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWA3LQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWA3LQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWA3LQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:16:12 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:24296 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932212AbWA3LQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:16:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Date: Mon, 30 Jan 2006 12:53:13 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <nigel@suspend2.net>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601271318.01985.rjw@sisk.pl> <20060130075301.GA16895@suse.de>
In-Reply-To: <20060130075301.GA16895@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301253.14274.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 30 January 2006 08:53, Stefan Seyfried wrote:
> On Fri, Jan 27, 2006 at 01:18:01PM +0100, Rafael J. Wysocki wrote:
> > On Friday, 27 January 2006 05:04, Nigel Cunningham wrote:
> 
> > > The simplest example would be:
> > > 
> > > dd if=/dev/hda of=/dev/null
> > > echo disk > /sys/power/state
> > 
> > Well, I don't think it's a usual kind of workload. :-)
> 
> Compiling a kernel, having updatedb and mandb run in the background
> and then trying to suspend while the compile still runs might do as well.
> 
> And this can happen, think of "battery-critical => suspend" setup.
> This is exactly the case i do not like the suspend to fail, because there
> might not be enough juice left to do a second try.

Still IMO we don't need all of the patches in the series to prevent this from
happening and it's quite difficult to single out the relevant change.

Greetings,
Rafael
