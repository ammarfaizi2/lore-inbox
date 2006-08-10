Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWHJEWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWHJEWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 00:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWHJEWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 00:22:44 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:4062 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161012AbWHJEWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 00:22:43 -0400
Date: Thu, 10 Aug 2006 00:22:16 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Joern Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] UML - support checkstack
Message-ID: <20060810042216.GA7754@ccure.user-mode-linux.org>
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org> <20060810020922.GO6908@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810020922.GO6908@waste.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 09:09:22PM -0500, Matt Mackall wrote:
> On Wed, Aug 09, 2006 at 02:15:24PM -0400, Jeff Dike wrote:
> > Make checkstack work for UML.  We need to pass the underlying architecture
> > name, rather than "um" to checkstack.pl.
> 
> Does this do the right thing with something like Voyager?

SUBARCH has a different meaning here.  For UML, it's the underlying,
host, architecture, not a variant architecture like Voyager.

> 
> Or should we just get together a small fund to send the remaining
> Voyager users proper computers?

Yeah, that's a plan :-)

				Jeff
