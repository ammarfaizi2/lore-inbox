Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWBHRRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWBHRRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWBHRRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:17:02 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:42677
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030292AbWBHRRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:17:01 -0500
Date: Wed, 8 Feb 2006 09:16:49 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060208171649.GA21373@kroah.com>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208170857.GA29818@srcf.ucam.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 05:08:58PM +0000, Matthew Garrett wrote:
> On Wed, Feb 08, 2006 at 08:58:03AM -0800, Greg KH wrote:
> > > +{
> > > +	down(&pm_sem);
> > 
> > Shouldn't this be a mutex?
> 
> It is, isn't it? The name's somewhat misleading, but I was just using 
> what already existed...

Ah, ok, nevermind, I thought this was new.

> +/**
> + *	pm_set_ac_status - Set the ac status callback. Returns true if the
> + *                         system is on AC and has a registered callback.

kerneldoc will not work with this.  It needs to be a one line, short,
description.  Put the full description below the function paramaters, it
can be as many lines as you want there.

thanks,

greg k-h
