Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbTIWS3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTIWS3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:29:39 -0400
Received: from home.kvack.org ([216.138.200.138]:34523 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S263346AbTIWS3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:29:35 -0400
Date: Tue, 23 Sep 2003 14:29:25 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923142925.A16490@kvack.org>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>; from tony.luck@intel.com on Tue, Sep 23, 2003 at 11:21:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 11:21:35AM -0700, Luck, Tony wrote:
> Looking at a couple of ia64 build servers here I see zero unaligned
> access messages in the logs.

ip options can still be an odd number of bytes.  Having itanic spew bogus 
log messages is just plain wrong (yet another hardware issue pushed off on 
software for no significant gain).

		-ben
-- 
"The software industry today survives only through an unstated agreement 
not to stir things up too much.  We must hope this lawsuit [by SCO] isn't 
the big stirring spoon." -- Ian Lance Taylor, Linux Journal, June 2003
