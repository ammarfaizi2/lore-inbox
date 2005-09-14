Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbVINNSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVINNSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVINNSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:18:55 -0400
Received: from mail.suse.de ([195.135.220.2]:20198 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965180AbVINNSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:18:54 -0400
Date: Wed, 14 Sep 2005 15:18:53 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1: end_pfn undefined in amd64-agp.ko
Message-ID: <20050914131853.GG11338@wotan.suse.de>
References: <17192.8799.432221.729771@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17192.8799.432221.729771@alkaid.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 03:15:11PM +0200, Mikael Pettersson wrote:
> Building amd64-agp as module in 2.6.14-rc1 for x86_64
> results in an error about "end_pfn" being undefined.
> 
> Looks like someone did s/max_mapnr/end_pfn/ in x86_64's
> page.h, but forgot to export end_pfn.

It's already fixed.

-Andi
