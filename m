Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbULXIgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbULXIgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 03:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbULXIgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 03:36:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55227 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261384AbULXIfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 03:35:55 -0500
Date: Fri, 24 Dec 2004 09:33:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [2/4]: add second parameter to clear_page() for all arches
Message-ID: <20041224083337.GA1043@openzaurus.ucw.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com> <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> o Extend clear_page to take an order parameter for all architectures.
> 

I believe you sould leave clear_page() as is, and introduce
clear_pages() with two arguments.
				Pavel

> -extern void clear_page (void *page);
> +extern void clear_page (void *page, int order);
>  extern void copy_page (void *to, void *from);
> 

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

