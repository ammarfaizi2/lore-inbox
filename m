Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWFIEBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWFIEBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 00:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWFIEBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 00:01:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965136AbWFIEBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 00:01:05 -0400
Date: Thu, 8 Jun 2006 21:00:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, marcelo.tosatti@cyclades.com,
       clameter@sgi.com
Subject: Re: [PATCH 04/14] Use per zone counters to remove
 zone_reclaim_interval
Message-Id: <20060608210056.9b2f3f13.akpm@osdl.org>
In-Reply-To: <20060608230305.25121.97821.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
	<20060608230305.25121.97821.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 16:03:05 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Caveat: The number of mapped pages includes anonymous pages.
> The current check works but is a bit too cautious. We could perform
> zone reclaim down to the last unmapped page if we would split NR_MAPPED
> into NR_MAPPED_PAGECACHE and NR_MAPPED_ANON. Maybe later.

That caveat should be in a code comment, please.  Otherwise we'll forget.

You have two [patch 04/14]s and no [patch 05/14].

