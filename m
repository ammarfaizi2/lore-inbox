Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbUIPQhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbUIPQhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUIPQff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:35:35 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63456 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268158AbUIPQa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:30:28 -0400
Date: Thu, 16 Sep 2004 09:30:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       Bob Picco <Robert.Picco@hp.com>, venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
In-Reply-To: <200409160909.12840.jbarnes@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0409160929440.6765@schroedinger.engr.sgi.com>
References: <200409161003.39258.bjorn.helgaas@hp.com> <200409160909.12840.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Jesse Barnes wrote:

> > As far as I can see, drivers/char/hpet.c talks to the same hardware.
> > HP sx1000 machines (and probably others) also implement the HPET.
>
> No, it's different hardware.
>
> > I think you should look at adding your functionality to hpet.c
> > rather than adding a new driver.
>
> I think Christoph already looked at that.  And HPET doesn't provide mmap
> functionality, does it?  I.e. allow a userspace program to dereference the
> counter register directly?

HPET also allows mmaping to userspace.

