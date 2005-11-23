Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVKWWaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVKWWaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVKWWaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:30:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23478 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932299AbVKWWaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:30:18 -0500
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Grover <andrew.grover@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
In-Reply-To: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 23:02:50 +0000
Message-Id: <1132786970.13095.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 12:26 -0800, Andrew Grover wrote:
> early next year. Until then, the code doesn't really *do* anything, but we
> wanted to release what we could right away, and start getting some 
> feedback.

First comment partly based on Jeff Garziks comments - if you added an
"operation" to the base functions and an operation mask to the DMA
engines it becomes possible to support engines that can do other ops (eg
abusing an NCR53c8xx for both copy and clear).

Second one - you obviously tested this somehow, was that all done by
simulation or do you have a "CPU" memcpy test engine for use before the
hardware pops up ?


