Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUIPQOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUIPQOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268440AbUIPQL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:11:58 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20653 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268355AbUIPQJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:09:41 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: device driver for the SGI system clock, mmtimer
Date: Thu, 16 Sep 2004 09:09:12 -0700
User-Agent: KMail/1.7
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Bob Picco <Robert.Picco@hp.com>, venkatesh.pallipadi@intel.com
References: <200409161003.39258.bjorn.helgaas@hp.com>
In-Reply-To: <200409161003.39258.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409160909.12840.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 16, 2004 9:03 am, Bjorn Helgaas wrote:
> Christoph Lameter wrote:
> > The timer hardware was designed around the multimedia timer specification
> > by Intel but to my knowledge only SGI has implemented that standard. The
> > driver was written by Jesse Barnes.
>
> As far as I can see, drivers/char/hpet.c talks to the same hardware.
> HP sx1000 machines (and probably others) also implement the HPET.

No, it's different hardware.

> I think you should look at adding your functionality to hpet.c
> rather than adding a new driver.

I think Christoph already looked at that.  And HPET doesn't provide mmap 
functionality, does it?  I.e. allow a userspace program to dereference the 
counter register directly?

Jesse
