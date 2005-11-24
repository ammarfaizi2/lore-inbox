Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVKXPh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVKXPh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVKXPh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:37:56 -0500
Received: from cantor2.suse.de ([195.135.220.15]:35728 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932158AbVKXPhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:37:55 -0500
Date: Thu, 24 Nov 2005 16:37:53 +0100
From: Andi Kleen <ak@suse.de>
To: Avi Kivity <avi@argo.co.il>
Cc: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@kvack.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
Message-ID: <20051124153753.GK20775@brahms.suse.de>
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com> <4384E7F2.2030508@pobox.com> <20051123223007.GA5921@wotan.suse.de> <20051124001700.GC14246@kvack.org> <20051124065037.GZ20775@brahms.suse.de> <4385DB32.7010605@argo.co.il> <20051124152924.GB5921@wotan.suse.de> <4385DDBE.3040208@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4385DDBE.3040208@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Just pointing out that it's not clear it will always be a big help.
> >
> > 
> >
> Agree it should default to in-cache.

This would mean no DMA engine by default.

Clearly there needs to be some heuristic to decide by default. We'll see how 
effective it will be in the end.

-Andi

