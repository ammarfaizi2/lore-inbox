Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVJJRTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVJJRTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVJJRTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:19:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751083AbVJJRTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:19:38 -0400
Date: Mon, 10 Oct 2005 13:19:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: WU Fengguang <wfg@mail.ustc.edu.cn>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] use radix_tree for non-resident page tracking
In-Reply-To: <20051010171414.GA8194@mail.ustc.edu.cn>
Message-ID: <Pine.LNX.4.63.0510101311280.20944@cuia.boston.redhat.com>
References: <20051010130705.GA5026@mail.ustc.edu.cn>
 <Pine.LNX.4.63.0510100959290.20944@cuia.boston.redhat.com>
 <20051010161704.GA7679@mail.ustc.edu.cn> <Pine.LNX.4.63.0510101237270.20944@cuia.boston.redhat.com>
 <20051010171414.GA8194@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2005, WU Fengguang wrote:

> I now realized that counters in struct zone should be better candidates.

Probably not, since a logical page could be swapped out from one
memory zone and paged back in to another.

-- 
All Rights Reversed
