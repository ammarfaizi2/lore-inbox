Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVJJQQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVJJQQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 12:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVJJQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 12:16:39 -0400
Received: from [218.22.21.1] ([218.22.21.1]:36840 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750882AbVJJQQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 12:16:38 -0400
Date: Tue, 11 Oct 2005 00:20:04 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@redhat.com>
Subject: Re: [RFC] use radix_tree for non-resident page tracking
Message-ID: <20051010162004.GA7958@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
References: <20051010130705.GA5026@mail.ustc.edu.cn> <Pine.LNX.4.63.0510100959290.20944@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510100959290.20944@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 10:00:30AM -0400, Rik van Riel wrote:
> How are you going to get the inter-reference distance
> this way?
> 
> I do not see how the radix tree provides you with the
> refault distance, which is needed to estimate the
> inter-reference distance.
How about taking down the current sum of `pgfree' in the slot?

-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui
