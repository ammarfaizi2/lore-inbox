Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752433AbWCPRNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbWCPRNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbWCPRNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:13:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:17061
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752433AbWCPRNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:13:32 -0500
Date: Thu, 16 Mar 2006 09:13:27 -0800
From: Greg KH <greg@kroah.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316171327.GA5620@kroah.com>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316170735.GA27311@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316170735.GA27311@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 09:07:35AM -0800, Greg KH wrote:
> On Thu, Mar 16, 2006 at 02:01:28AM -0800, akpm@osdl.org wrote:
> > 
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > We have no less than 65 implementations of TRUE and FALSE in the tree, so the
> > inevitable happened:
> > 
> > In file included from drivers/pci/hotplug/ibmphp_core.c:40:
> > drivers/pci/hotplug/ibmphp.h:409:1: warning: "FALSE" redefined
> > In file included from include/acpi/acpi.h:55,
> >                  from drivers/pci/hotplug/pci_hotplug.h:187,
> >                  from drivers/pci/hotplug/ibmphp.h:33,
> >                  from drivers/pci/hotplug/ibmphp_core.c:40:
> > include/acpi/actypes.h:336:1: warning: this is the location of the previous definition
> 
> I have a patch in my queue that fixes this, in the ibmphp driver.

Pushed out into my tree now, if you want to update your copy.

thanks,

greg k-h
