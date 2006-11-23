Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933300AbWKWJCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933300AbWKWJCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933299AbWKWJCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:02:40 -0500
Received: from mail.suse.de ([195.135.220.2]:55439 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933300AbWKWJCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:02:39 -0500
Date: Thu, 23 Nov 2006 10:02:36 +0100
From: Andi Kleen <ak@suse.de>
To: Rohit Seth <rohitseth@google.com>
Cc: Andi Kleen <ak@suse.de>, Mel Gorman <mel@csn.ul.ie>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch2/4]: fake numa for x86_64 patches
Message-ID: <20061123090236.GC29738@bingen.suse.de>
References: <1164245667.29844.151.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164245667.29844.151.camel@galaxy.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 05:34:27PM -0800, Rohit Seth wrote:
> This patch increases the NODE_SHIFT from 6 to 8 to allow maximum of 256
> nodes.

Well you just change the default? Why do you think it's a good default?
I think it's a bit too large for a default, using too much memory etc.

Of course any custom build can use a non default value.

-Andi

