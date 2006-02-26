Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWBZXvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWBZXvo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWBZXvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:51:43 -0500
Received: from colin.muc.de ([193.149.48.1]:272 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751437AbWBZXvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:51:43 -0500
Date: 27 Feb 2006 00:51:42 +0100
Date: Mon, 27 Feb 2006 00:51:42 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: largret@gmail.com, 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: OOM-killer too aggressive?
Message-ID: <20060226235142.GB91959@muc.de>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com> <20060226102152.69728696.akpm@osdl.org> <1140988015.5178.15.camel@shogun.daga.dyndns.org> <20060226133140.4cf05ea5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226133140.4cf05ea5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thinking about this more I think we need a __GFP_NOOOM for other
purposes too. e.g. the x86-64 IOMMU code tries to do similar
fallbacks and I suspect it will be hit by the OOM killer too.

-Andi

