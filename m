Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUC0Nw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 08:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUC0Nw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 08:52:56 -0500
Received: from mail.shareable.org ([81.29.64.88]:19602 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261735AbUC0Nwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 08:52:55 -0500
Date: Sat, 27 Mar 2004 13:52:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/22] /dev/random: kill batching of entropy mixing
Message-ID: <20040327135245.GD21884@mail.shareable.org>
References: <21.524465763@selenic.com> <22.524465763@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22.524465763@selenic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> Rather than batching up entropy samples, resulting in longer lock hold
> times when we actually process the samples, mix in samples
> immediately. The trickle code should eliminate almost all the
> additional interrupt-time overhead this would otherwise incur, with or
> without locking.

What do you mean by "the trickle code"?  I didn't see anything in your
patch set which makes the interrupt-time overhead faster.

-- Jamie
