Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUHAU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUHAU1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 16:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUHAU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 16:27:13 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:25297 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S266170AbUHAU1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 16:27:12 -0400
Date: Sun, 1 Aug 2004 22:26:59 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI removable devices problem
Message-ID: <20040801202659.GA30205@hout.vanvergehaald.nl>
References: <20040801141931.6e026422.pochini@shiny.it> <20040801092421.3f138fac.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801092421.3f138fac.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 09:24:21AM -0700, Randy.Dunlap wrote:
> On Sun, 1 Aug 2004 14:19:31 +0200 Giuliano Pochini wrote:
> 
> > mount: /dev/sdb1 is not a valid block device
> 
> I think that it's been this way for some time now...
> 
> Does using
> 	blockdev --rereadpt /dev/sdb1
> help?

You probably meant to write:
	blockdev --rereadpt /dev/sdb

Regards,
Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
