Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUIJAGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUIJAGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUIJAGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:06:52 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:19399 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265805AbUIIX7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:59:37 -0400
Date: Thu, 9 Sep 2004 16:59:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040909235924.GA14161@taniwha.stupidest.org>
References: <20040909232532.GA13572@taniwha.stupidest.org> <4140ED57.3090704@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4140ED57.3090704@quark.didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 07:55:03PM -0400, Brian Gerst wrote:

> What's the point of changing 4KSTACKS to I386_4KSTACKS?

Two (no very good reasons).  (1) I wanted to make it clear it was an
i386 specific thing (2) it made grepping for old vs new changes more
obvious

> Best to just leave this alone as external code is likely to check
> it.

i personally prefer the change but am not against dropping it if
people object


