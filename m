Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVFANkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVFANkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFANkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:40:39 -0400
Received: from holomorphy.com ([66.93.40.71]:6333 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261278AbVFANke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:40:34 -0400
Date: Wed, 1 Jun 2005 06:40:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Bala??ic <david.balazic@hermes.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
Message-ID: <20050601134022.GM20782@holomorphy.com>
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050601T150142-941@post.gmane.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 01:02:13PM +0000, David Bala??ic wrote:
> OK, so can anyone tell the actual, current limits ?

Without CONFIG_HIGHMEM64G=y you have:
32 swapfiles, max swapfile size of 64GB.

With CONFIG_HIGHMEM64G=y you have:
32 swapfiles, max swapfile size of 512GB.


-- wli
