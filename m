Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWETWSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWETWSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWETWSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 18:18:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43427 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932405AbWETWSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 18:18:13 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
Date: Sun, 21 May 2006 00:17:59 +0200
User-Agent: KMail/1.9.1
Cc: mel@csn.ul.ie, davej@codemonkey.org.uk, tony.luck@intel.com,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
References: <20060508141030.26912.93090.sendpatchset@skynet> <200605202327.19606.ak@suse.de> <20060520144043.22f993b1.akpm@osdl.org>
In-Reply-To: <20060520144043.22f993b1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605210017.59984.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Well, it creates arch-neutral common code, teaches various architectures
> use it.  It's the sort of thing we do all the time.
> 
> These things are opportunities to eliminate crufty arch code which few
> people understand and replace them with new, clean common code which lots
> of people understand.  That's not a bad thing to be doing.

I'm not fundamentally against that, but so far it seems to just generate lots of 
new bugs?  I'm not sure it's really worth the pain.

-Andi
