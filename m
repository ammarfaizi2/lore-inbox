Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267238AbUIHN3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUIHN3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUIHN1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:27:35 -0400
Received: from holomorphy.com ([207.189.100.168]:63655 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267709AbUIHNJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:09:23 -0400
Date: Wed, 8 Sep 2004 06:09:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908130908.GE3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Scott Wood <scott@timesys.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com> <20040908140146.A31601@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908140146.A31601@infradead.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 05:57:55AM -0700, William Lee Irwin III wrote:
>> It may be time for a __weak define to abbreviate __attribute__((weak));
>> we seem to use it in enough places.

On Wed, Sep 08, 2004 at 02:01:46PM +0100, Christoph Hellwig wrote:
> Personally I'm extremly unhappy with that week model for things like
> this.  There's no reason why architectures could implement irq handling
> as inlines.  Or in case of s390 not at all.

If there's a question of "not at all" that probably rules out weak
symbols as a method of handling it.


-- wli
