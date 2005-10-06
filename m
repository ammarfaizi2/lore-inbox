Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVJFXUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVJFXUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVJFXUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:20:35 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47295 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751214AbVJFXUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:20:35 -0400
Date: Thu, 6 Oct 2005 18:20:32 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 0/22] ppc64: Full sequence of PCI Error recovery patches
Message-ID: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH 0/22] ppc64: Full sequence of PCI Error recovery patches

The following sequence of patches implement the full set of 
PCI error recovery functions for ppc64. There are a large 
numer of patches because I've attempted to keep the scope 
of each patch reasonably small, and thus easy to review.
(The system should remain usable and functional after applying 
each patch).

A detailed explanation of what this is and how it works is
in patch 6/22; if you don't already know what this is about,
that would be the place to start reading.

These patches result in systems that have survived multi-hour
runs with thousands of PCI errors injected. Although this is
good, I still can't warrent that this is bug-free, as there
are still hardware combos that haven't been tested. But for 
now, it seems to work.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

