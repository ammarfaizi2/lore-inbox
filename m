Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUBDXoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUBDXoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:44:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:40378 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264954AbUBDXlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:41:14 -0500
Date: Wed, 4 Feb 2004 15:38:40 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI / OF linkage in sysfs
Message-ID: <20040204233840.GA5375@kroah.com>
References: <1075878713.992.3.camel@gaston> <Pine.LNX.4.58.0402041407160.2086@home.osdl.org> <20040204231324.GA5078@kroah.com> <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 03:28:21PM -0800, Linus Torvalds wrote:
> 
> On Wed, 4 Feb 2004, Greg KH wrote:
> > 
> > Or, if you really want to be able to get the OF info from the pci device
> > in sysfs, why not create a symlink in the pci device directory pointing
> > to your OF path in sysfs?  That would seem like the best option.
> 
> Where does this stop? Do we start doing the same for all different kinds 
> of buses, and all kinds of firmware? 

Ok, good point.  You're right in that way we would eventually end up
with a huge mess...

Sorry Ben.

greg k-h
