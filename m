Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUHYU76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUHYU76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUHYUzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:55:43 -0400
Received: from holomorphy.com ([207.189.100.168]:41871 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268696AbUHYUuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:50:55 -0400
Date: Wed, 25 Aug 2004 13:50:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
Message-ID: <20040825205045.GI2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Con Kolivas <kernel@kolivas.org>,
	ck kernel mailing list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <412880BF.6050503@kolivas.org> <Pine.LNX.4.44.0408251621160.5145-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408251621160.5145-100000@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Con Kolivas wrote:
>> Added since 2.6.8.1-ck3:
>> +mapped_watermark.diff

On Wed, Aug 25, 2004 at 04:22:32PM -0400, Rik van Riel wrote:
> Sounds like a bad idea for file servers ;)
> Wouldn't it be better to lazily move these cached pages to
> a "cached" list like the BSDs have, and reclaim it immediately
> when the memory is needed for something else ?
> It should be easy enough to keep the cached data around and
> still have the cache pages easily reclaimable.

This will be unmapped and clean; but that's not certain to be enough.
We must ask at what cost comes aggressive caching.


-- wli
