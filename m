Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264794AbTFESOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264807AbTFESOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:14:16 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53742 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264794AbTFESOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:14:00 -0400
Date: Thu, 5 Jun 2003 14:27:12 -0400
From: Matt Wilson <msw@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>, tinglett@us.ibm.com,
       engebret@us.ibm.com, jdewand@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
       torvalds@transmeta.com, bcollins@debian.org, wli@holomorphy.com,
       tom_gall@vnet.ibm.com, anton@samba.org
Subject: Re: /proc/bus/pci
Message-ID: <20030605142711.C14735@devserv.devel.redhat.com>
References: <1054783303.22104.5569.camel@cube> <20030605165831.GA5235@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030605165831.GA5235@kroah.com>; from greg@kroah.com on Thu, Jun 05, 2003 at 09:58:31AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 09:58:31AM -0700, Greg KH wrote:
> 
> We agreed that we should call this a "domain", too, and he has a patch
> that he says works for X.
> 
> Hopefully this prod will get him to send out his patch :)

it's a simple change to parsing /proc/bus/pci/devices in
xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_pci.c.  For the
rest of pci setup, you need to write arch specific code in
xc/programs/Xserver/hw/xfree86/os-support/bus/* anyway.

Cheers,

Matt
msw@redhat.com
--
Matt Wilson
Manager, Base Operating Systems
Red Hat, Inc.
