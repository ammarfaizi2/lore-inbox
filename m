Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUIXCcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUIXCcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIXC3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:29:01 -0400
Received: from holomorphy.com ([207.189.100.168]:4060 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267585AbUIXC1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:27:44 -0400
Date: Thu, 23 Sep 2004 19:27:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Fusco <fusco_john@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [vm 3/4] convert direct callers of remap_page_range()
Message-ID: <20040924022741.GQ9106@holomorphy.com>
References: <41535AAE.6090700@yahoo.com> <20040924021735.GL9106@holomorphy.com> <20040924021954.GM9106@holomorphy.com> <20040924022123.GN9106@holomorphy.com> <20040924022329.GO9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924022329.GO9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 07:21:23PM -0700, William Lee Irwin III wrote:
>> Eliminate callers of remap_page_range() via io_remap_page_range().

On Thu, Sep 23, 2004 at 07:23:29PM -0700, William Lee Irwin III wrote:
> Eliminate direct callers of remap_page_range().

Notable here is the following:

$ diffstat patches/caller-drivers.patch|& tail -1
 58 files changed, 147 insertions(+), 233 deletions(-)

-- wli
