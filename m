Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUHFU4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUHFU4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268291AbUHFUvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:51:47 -0400
Received: from holomorphy.com ([207.189.100.168]:32207 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268300AbUHFUqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:46:48 -0400
Date: Fri, 6 Aug 2004 13:46:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Josh Aas <josha@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] improve speed of freeing bootmem
Message-ID: <20040806204644.GR17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Josh Aas <josha@sgi.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <4113DB63.9020706@sgi.com> <20040806125216.30405230.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806125216.30405230.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Aas <josha@sgi.com> wrote:
>> Attached is a patch that greatly improves the speed of freeing boot 
>> memory.

On Fri, Aug 06, 2004 at 12:52:16PM -0700, Andrew Morton wrote:
> hm, OK.  I have a vague feeling that Bill Irwin had patches to fix this up
> ages ago.

I'm going to do some further work here and bring some patches that
are simplifications of the most widely distributed ones I wrote up to
current, get them tested on a few architectures, and so on. The testing
cycle for this will probably take a couple of weeks, and it's a much
larger change, so I think Josh's solution is a good interim solution.
Merging it also helps in the event that the data structure changes
I'm working on don't work out or end up going through an unusually long
testing cycle.


-- wli
