Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVI1Rki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVI1Rki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVI1Rki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:40:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17638 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751422AbVI1Rkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:40:37 -0400
Date: Wed, 28 Sep 2005 10:40:34 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Seth, Rohit" <rohit.seth@intel.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: show_free_area shows free pages in pcp list
In-Reply-To: <20050928102219.A29282@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0509281037240.14338@schroedinger.engr.sgi.com>
References: <20050928102219.A29282@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Seth, Rohit wrote:

> [PATCH]: The count field in pcp list represents the free pages in that list. 

Well, lets keep it the way it is.

Its the number of free pages used by the pcp list.

Its  true that these are pages that are not "used" by the system but they 
are in use for the cache and not accounted for by the number of free 
pages.


