Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUCSSnr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUCSSnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:43:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:61354 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263062AbUCSSnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:43:45 -0500
Date: Fri, 19 Mar 2004 09:57:02 -0800
From: Greg KH <greg@kroah.com>
To: Martin Hicks <mort@wildopensource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exporting physical topology information
Message-ID: <20040319175702.GA10432@kroah.com>
References: <20040317213714.GD23195@localhost> <20040318232139.GA17586@kroah.com> <20040319174826.GC19428@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319174826.GC19428@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 12:48:26PM -0500, Martin Hicks wrote:
> 
> On Thu, Mar 18, 2004 at 03:21:39PM -0800, Greg KH wrote:
> > On Wed, Mar 17, 2004 at 04:37:14PM -0500, Martin Hicks wrote:
> > > 
> > > Hi,
> > > 
> > > If we could physically locate a PCI bus, then it would be much easier
> > > to (for example) locate our defective SCSI disk that is target4 on the
> > > SCSI controller that is on pci bus 0000:20.
> > 
> > Um, what's wrong with the current /sys/class/pci_bus/*/cpuaffinity files
> > for determining this topology information?  That is why it was added.
> 
> This gives us more logical topology information.  It still doesn't tell
> us where in the room the specific piece of equipment is.

True, but isn't that what labels on your CPU nodes are for?

:)

greg k-h
