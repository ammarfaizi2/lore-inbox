Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUAPEZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 23:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUAPEZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 23:25:42 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:7299 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263880AbUAPEZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 23:25:40 -0500
Date: Fri, 16 Jan 2004 04:25:00 +0000
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Kieran Morrissey <linux@mgpenguin.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c for long device names.
Message-ID: <20040116042500.GA3658@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Kieran Morrissey <linux@mgpenguin.net>,
	linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net> <40061188.8060705@pobox.com> <20040116012314.GN23253@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116012314.GN23253@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 05:23:14PM -0800, Greg KH wrote:

 > > Well, appreciated, but we really do need to remove it.  We don't need 
 > > these strings in the kernel at all.  pci.ids is just a static lookup 
 > > table that is best kept in userspace.
 > 
 > It will be removed in 2.7.

So I'm the only one with deja vu ?

My recollection of history went something like..

2.2 - Marked as OBSOLETE when /proc/bus/pci came to town.
      iirc, even Martin Mares (PCI maintainer at the time) wanted
	  it removed in 2.3.x
2.3 - Linus decides he likes it, and wants to keep it.
2.4 - Unmarked OBSOLETE
2.5 - Silence, (though we now get PCI stuff in /sys too, woo!)
2.6 - "It will be removed in 2.7"

Anyone else spot a pattern ?  8-)

		Dave

