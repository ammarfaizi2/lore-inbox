Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUGRNMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUGRNMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 09:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUGRNMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 09:12:25 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:8368 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S263971AbUGRNMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 09:12:24 -0400
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, John Hawkes <hawkes@sgi.com>,
       Martin Hicks <mort@wildopensource.com>,
       Shai Fultheim <Shai@ScaleMP.com>
Subject: Re: [PATCH] reduce inter-node balancing frequency
References: <200407151829.20069.jbarnes@engr.sgi.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 18 Jul 2004 09:12:13 -0400
In-Reply-To: <200407151829.20069.jbarnes@engr.sgi.com>
Message-ID: <yq08ydhsbma.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jesse" == Jesse Barnes <jbarnes@engr.sgi.com> writes:

Jesse> Nick, we've had this patch floating around for awhile now and
Jesse> I'm wondering what you think.  It's needed to boot systems with
Jesse> lots (e.g. 256) nodes, but could probably be done another way.
Jesse> Do you think we should create a scheduler domain for every 64
Jesse> nodes or something?  Any other NUMA folks have thoughts about
Jesse> these values?

vSMP could use something like this as well. I think Martin Hicks
already did an arch-aware patch for setting these things.

Jes
