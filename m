Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTFETUe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTFETUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:20:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:59871 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264899AbTFETUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:20:33 -0400
Date: Thu, 5 Jun 2003 12:35:38 -0700
From: Greg KH <greg@kroah.com>
To: Matt Wilson <msw@redhat.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>, tinglett@us.ibm.com,
       engebret@us.ibm.com, jdewand@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
       torvalds@transmeta.com, bcollins@debian.org, wli@holomorphy.com,
       tom_gall@vnet.ibm.com, anton@samba.org
Subject: Re: /proc/bus/pci
Message-ID: <20030605193538.GD5633@kroah.com>
References: <1054783303.22104.5569.camel@cube> <20030605165831.GA5235@kroah.com> <20030605142711.C14735@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605142711.C14735@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 02:27:12PM -0400, Matt Wilson wrote:
> On Thu, Jun 05, 2003 at 09:58:31AM -0700, Greg KH wrote:
> > 
> > We agreed that we should call this a "domain", too, and he has a patch
> > that he says works for X.
> > 
> > Hopefully this prod will get him to send out his patch :)
> 
> it's a simple change to parsing /proc/bus/pci/devices in
> xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_pci.c.  For the
> rest of pci setup, you need to write arch specific code in
> xc/programs/Xserver/hw/xfree86/os-support/bus/* anyway.

No, I meant your kernel patches that add domain support in a sane way.
I don't care about X patches :)

thanks,

greg k-h
