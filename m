Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUIPQhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUIPQhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268334AbUIPQgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:36:01 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45033 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268340AbUIPQeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:34:15 -0400
Date: Thu, 16 Sep 2004 09:32:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@engr.sgi.com>,
       Bob Picco <Robert.Picco@hp.com>, venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
In-Reply-To: <200409161003.39258.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.58.0409160930300.6765@schroedinger.engr.sgi.com>
References: <200409161003.39258.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Bjorn Helgaas wrote:

> Christoph Lameter wrote:
> > The timer hardware was designed around the multimedia timer specification by Intel
> > but to my knowledge only SGI has implemented that standard. The driver was written
> > by Jesse Barnes.
>
> As far as I can see, drivers/char/hpet.c talks to the same hardware.
> HP sx1000 machines (and probably others) also implement the HPET.

The Intel Multimedia Standard is a earlier and different timer spec.
