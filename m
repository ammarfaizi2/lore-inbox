Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUCSRs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbUCSRs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:48:28 -0500
Received: from galileo.bork.org ([66.11.174.156]:23713 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262345AbUCSRs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:48:27 -0500
Date: Fri, 19 Mar 2004 12:48:26 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exporting physical topology information
Message-ID: <20040319174826.GC19428@localhost>
References: <20040317213714.GD23195@localhost> <20040318232139.GA17586@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318232139.GA17586@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 18, 2004 at 03:21:39PM -0800, Greg KH wrote:
> On Wed, Mar 17, 2004 at 04:37:14PM -0500, Martin Hicks wrote:
> > 
> > Hi,
> > 
> > If we could physically locate a PCI bus, then it would be much easier
> > to (for example) locate our defective SCSI disk that is target4 on the
> > SCSI controller that is on pci bus 0000:20.
> 
> Um, what's wrong with the current /sys/class/pci_bus/*/cpuaffinity files
> for determining this topology information?  That is why it was added.

This gives us more logical topology information.  It still doesn't tell
us where in the room the specific piece of equipment is.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
