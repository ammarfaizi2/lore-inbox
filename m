Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWDVV5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWDVV5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWDVV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:57:13 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:35203 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S1751198AbWDVV5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:57:12 -0400
Date: Sat, 22 Apr 2006 14:57:08 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
In-Reply-To: <fa.aQp/JAmWqmBjqeleRNK2yrIEx2o@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0604221454010.19893@osa.unixfolk.com>
References: <fa.mZJQjHk9A5D4GHpUn7lttlNhH5U@ifi.uio.no>
 <fa.aQp/JAmWqmBjqeleRNK2yrIEx2o@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006, Roland Dreier wrote:

|     Adrian> As an example, the only usage of bus_to_virt() in the
|     Adrian> infiniband code was added in 2.6.17-rc1 (sic).
| 
| Ugh, the pathscale guys snuck that one past me in the ipath merge.
| I'll see what I can do about it...

Already fixed in our current code, with patches headed off to you
(Roland) very soon now...

Dave Olson
olson@pathscale.com
olson@unixfolk.com
http://www.unixfolk.com/dave
