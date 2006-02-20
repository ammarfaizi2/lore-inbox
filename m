Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWBTAqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWBTAqr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBTAqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:46:47 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11727
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751154AbWBTAqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:46:46 -0500
Date: Sun, 19 Feb 2006 16:46:35 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@suse.cz>, torvalds@osdl.org, akpm@osdl.org,
       linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power states in sysfs interface
Message-ID: <20060220004635.GA22576@kroah.com>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net> <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 03:59:25PM -0800, Patrick Mochel wrote:
> 
> On Sat, 18 Feb 2006, Pavel Machek wrote:
> 
> > Hi!
> >
> > > Fix the per-device state file to respect the actual state that
> > > is reported by the device, or written to the file.
> >
> > Can we let "state" file die? You actually suggested that at one point.
> >
> > I do not think passing states in u32 is good idea. New interface that passes
> > state as string would probably be better.
> 
> Yup, in the future that will be better. For now, let's work with what we
> got and fix 2.6.16 to be compatible with previous versions..

It's _way_ too late in the 2.6.16 cycle for this series of patches, if
that is what you are proposing.

thanks,

greg k-h
