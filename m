Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUIPQIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUIPQIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268176AbUIPQIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:08:06 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:28888 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S268142AbUIPQDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:03:51 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: device driver for the SGI system clock, mmtimer
Date: Thu, 16 Sep 2004 10:03:39 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@engr.sgi.com>,
       Bob Picco <Robert.Picco@hp.com>, venkatesh.pallipadi@intel.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409161003.39258.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> The timer hardware was designed around the multimedia timer specification by Intel
> but to my knowledge only SGI has implemented that standard. The driver was written
> by Jesse Barnes.

As far as I can see, drivers/char/hpet.c talks to the same hardware.
HP sx1000 machines (and probably others) also implement the HPET.

I think you should look at adding your functionality to hpet.c
rather than adding a new driver.
