Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWBHHJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWBHHJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWBHHJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:09:21 -0500
Received: from cabal.ca ([134.117.69.58]:32188 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161014AbWBHHJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:09:21 -0500
Date: Wed, 8 Feb 2006 02:07:58 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       grundler@parisc-linux.org
Subject: Re: [PATCH] unify pfn_to_page take 2 [16/25] parisc funcs
Message-ID: <20060208070758.GB21184@quicksilver.road.mcmartin.ca>
References: <43E98C73.2050903@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E98C73.2050903@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 03:15:15PM +0900, KAMEZAWA Hiroyuki wrote:
> parisc can use generic funcs.
>

ACK... Looks fine to me. Maybe the BUG_ON(zone == NULL) in page_to_pfn might
be worth keeping? 

Cheers,
	Kyle
