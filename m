Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbTLNE1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 23:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265341AbTLNE1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 23:27:22 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:4228 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S265340AbTLNE1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 23:27:22 -0500
Date: Sun, 14 Dec 2003 04:27:14 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031214042714.GB21241@mail.shareable.org>
References: <200312140407.28580.ross@datscreative.com.au> <200312140916.26005.ross@datscreative.com.au> <1071357683.2024.5.camel@big.pomac.com> <200312140949.52489.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312140949.52489.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> The v1 patch ((cpu_khz >> 12)+200) gave 700ns additional delay to
> your existing code path so I think I was being too optimistic in the
> initial v2 timing. I made the initial timing CPU freq dependent on
> the assumption that a faster cpu would get to the delay point
> quicker.

Maybe it scales with bus speed, not CPU internal speed?

-- Jamie
