Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUFAIcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUFAIcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 04:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbUFAIcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 04:32:24 -0400
Received: from holomorphy.com ([207.189.100.168]:51854 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264923AbUFAIcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 04:32:23 -0400
Date: Tue, 1 Jun 2004 01:32:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Bradford <john@grabjohn.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Michael Brennan <mbrennan@ezrs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040601083206.GI2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Bradford <john@grabjohn.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Michael Brennan <mbrennan@ezrs.com>, linux-kernel@vger.kernel.org
References: <40BB88B5.8080300@ezrs.com> <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk> <40BBB5F7.1010407@yahoo.com.au> <200406010834.i518Y1cT000414@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406010834.i518Y1cT000414@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 09:34:01AM +0100, John Bradford wrote:
> Sure, but tell me, for example, what is the point of having swap on a system
> like this:
> $ free
>              total       used       free     shared    buffers     cached
> Mem:        516688      19900     496788          0        628      11276
> -/+ buffers/cache:       7996     508692
> Swap:            0          0          0

So you can move userspace pages out of ZONE_DMA as-needed.


-- wli
