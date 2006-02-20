Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWBTReJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWBTReJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWBTReJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:34:09 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:35775
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161072AbWBTReH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:34:07 -0500
Date: Mon, 20 Feb 2006 09:33:53 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.16-rc4-mm1: usbfs2 multiply defined symbols
Message-ID: <20060220173353.GA5980@kroah.com>
References: <20060220042615.5af1bddc.akpm@osdl.org> <20060220143713.GA4661@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220143713.GA4661@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 03:37:13PM +0100, Adrian Bunk wrote:
> On Mon, Feb 20, 2006 at 04:26:15AM -0800, Andrew Morton wrote:
> >...
> > +gregkh-usb-usbfs2.patch
> > 
> >  USB tree updates
> >...
> 
> This patch causes the following compile error:

Known issue, don't build in usbfs2 directly in the kernel just yet.

thanks,

greg k-h
