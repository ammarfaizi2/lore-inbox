Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754539AbWKHLzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbWKHLzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbWKHLze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:55:34 -0500
Received: from cantor.suse.de ([195.135.220.2]:44965 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754539AbWKHLze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:55:34 -0500
From: Andi Kleen <ak@suse.de>
To: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH] Update MMCONFIG resource insertion to check against e820 map.
Date: Wed, 8 Nov 2006 12:54:31 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Matthew Wilcox" <matthew@wil.cx>,
       "Jeff Chua" <jeff.chua.linux@gmail.com>, discuss@x86-64.org
References: <8f95bb250611071249i6cf92b98p99d4b08275de6656@mail.gmail.com>
In-Reply-To: <8f95bb250611071249i6cf92b98p99d4b08275de6656@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611081254.31635.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 November 2006 21:49, Aaron Durbin wrote:
> Check to see if MMCONFIG region is marked as reserved in the e820 map
> before inserting the MMCONFIG region into the resource map. If the region
> is not entirely marked as reserved in the e820 map attempt to find a region
> that is. Only insert the MMCONFIG region into the resource map if there was
> a region found marked as reserved in the e820 map.  This should fix a known
> regression in 2.6.19 by not reserving all of the I/O space on misconfigured
> systems.

Jeff, did this fix your problem?

-Andi
