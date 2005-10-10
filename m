Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVJJOAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVJJOAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVJJOAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:00:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12435 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750805AbVJJOAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:00:35 -0400
Date: Mon, 10 Oct 2005 10:00:30 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: WU Fengguang <wfg@mail.ustc.edu.cn>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] use radix_tree for non-resident page tracking
In-Reply-To: <20051010130705.GA5026@mail.ustc.edu.cn>
Message-ID: <Pine.LNX.4.63.0510100959290.20944@cuia.boston.redhat.com>
References: <20051010130705.GA5026@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, WU Fengguang wrote:

> The CLOCK-Pro page replacement is quite appealing, and I'd like to 
> contribute an idea: How about store bookkeeping info of dropped pages 
> in-place in radix_tree?

How are you going to get the inter-reference distance
this way?

I do not see how the radix tree provides you with the
refault distance, which is needed to estimate the
inter-reference distance.

-- 
All Rights Reversed
