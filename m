Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUJOSbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUJOSbR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUJOSbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:31:16 -0400
Received: from holomorphy.com ([207.189.100.168]:15244 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268283AbUJOSbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:31:09 -0400
Date: Fri, 15 Oct 2004 11:30:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Albert Cahalan <albert@users.sf.net>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015183025.GN5607@holomorphy.com>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube> <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube> <20041015171355.GD17849@dualathlon.random> <1097862714.2666.13650.camel@cube> <20041015181446.GF17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015181446.GF17849@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 08:14:46PM +0200, Andrea Arcangeli wrote:
> that you can't get those values efficiently. Even assuming you're ok to
> drop shared by disabling SHR, it wouldn't help, without a kernel API
> change.

On Fri, Oct 15, 2004 at 01:51:56PM -0400, Albert Cahalan wrote:
>> Well, as long as it makes the users happy... I don't personally
>> care, except to say that I don't care to document all sorts
>> of kernel-specific variations. It gets hopelessly messy.

On Fri, Oct 15, 2004 at 08:14:46PM +0200, Andrea Arcangeli wrote:
> Yep, I believe users could be happy with Hugh's rss-anon_rss variant.

I just checked in with some Oracle people and the primary concern
is splitting up RSS into shared and private. Given either shared
or private the other is calculable.


-- wli
