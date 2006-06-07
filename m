Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWFGVqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWFGVqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWFGVqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:46:18 -0400
Received: from xenotime.net ([66.160.160.81]:45488 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932432AbWFGVqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:46:17 -0400
Date: Wed, 7 Jun 2006 14:48:59 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Paul Fulghum <paulkf@microgate.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, khc@pm.waw.pl
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
Message-Id: <20060607144859.3ae7bb6d.rdunlap@xenotime.net>
In-Reply-To: <4487488F.3010100@microgate.com>
References: <1149694978.12920.14.camel@amdx2.microgate.com>
	<20060607143138.62855633.rdunlap@xenotime.net>
	<4487488F.3010100@microgate.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 16:43:43 -0500 Paul Fulghum wrote:

> Randy.Dunlap wrote:
> > See my new patch below.  All done in Kconfig, no
> > source file changes needed.  Highly preferable. :)
> 
> The effect is the exact same as mine (if there is a mismatch
> then generic HDLC support for synclink is silently disabled),
> and your patch is against a patch that has already been dropped.
> 
> The only difference is the granularity of enabling
> the HDLC option for individual synclink adapter types,
> which is not really an issue (as this is not in <= 2.6.16 anyways).
> 
> I'd prefer to stick with my patch as it is simpler,
> and maintains compatibility with the way thing are done
> in <= 2.6.16 (customer documentation does not need updating).

Sure, that's fine, your call.

I just wanted you to see how this is handled in some other places
in the kernel tree.

---
~Randy
