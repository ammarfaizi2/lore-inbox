Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbULXQSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbULXQSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 11:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbULXQSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 11:18:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28562 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261235AbULXQSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 11:18:31 -0500
Date: Fri, 24 Dec 2004 08:18:26 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Pavel Machek <pavel@ucw.cz>
cc: akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [2/4]: add second parameter to clear_page() for
 all arches
In-Reply-To: <20041224083337.GA1043@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.58.0412240818030.6505@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <20041224083337.GA1043@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004, Pavel Machek wrote:

> Hi!
>
> > o Extend clear_page to take an order parameter for all architectures.
> >
>
> I believe you sould leave clear_page() as is, and introduce
> clear_pages() with two arguments.

Did that in V1 and Andi Kleen complained about it.
