Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTA1WMW>; Tue, 28 Jan 2003 17:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbTA1WMW>; Tue, 28 Jan 2003 17:12:22 -0500
Received: from ldap.somanetworks.com ([216.126.67.42]:2524 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S261530AbTA1WMV>; Tue, 28 Jan 2003 17:12:21 -0500
Date: Tue, 28 Jan 2003 17:21:37 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Greg KH <greg@kroah.com>
cc: Stanley Wang <stanley.wang@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Re: [RFC] Get rid of all procfs stuff for PCI
 subsystem.
In-Reply-To: <20030128215644.GA7382@kroah.com>
Message-ID: <Pine.LNX.4.44.0301281718090.10921-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Greg KH wrote:

> On Tue, Jan 28, 2003 at 05:59:28PM +0800, Stanley Wang wrote:
> > Hi, Greg
> > When did I try to remove all procfs stuff from pci_hotplug_core.c,
> > I found I could only cut little codes off.
> 
> But you cut out everything that was there, right?  There wasn't much.
> 
> > So I suggest:
> > How about to get rid of all procfs stuff for PCI subsystem?
> > It could reduce about 700 lines codes from the kernel.
> > I think we could get all information from sysfs, right?
> > But it may break some user mode utilities.
> 
> If you look, a lot of it is now under a config option to just not enable
> it at all, which helps out a lot.

Is there a plan to update pci-utils to work with sysfs?  lspci is a pretty
valuable debugging tool, it would be a shame to lose the use of it in 2.6.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

