Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUJOVnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUJOVnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUJOVnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:43:02 -0400
Received: from holomorphy.com ([207.189.100.168]:32909 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268479AbUJOVki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:40:38 -0400
Date: Fri, 15 Oct 2004 14:40:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Albert Cahalan <albert@users.sf.net>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015214026.GR5607@holomorphy.com>
References: <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube> <20041015171355.GD17849@dualathlon.random> <1097862714.2666.13650.camel@cube> <20041015181446.GF17849@dualathlon.random> <20041015183025.GN5607@holomorphy.com> <20041015184009.GG17849@dualathlon.random> <20041015184713.GO5607@holomorphy.com> <20041015211626.GQ5607@holomorphy.com> <20041015212831.GL17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015212831.GL17849@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 02:16:26PM -0700, William Lee Irwin III wrote:
>> they're only waiting for ports to the vendor kernel(s) now.

On Fri, Oct 15, 2004 at 11:28:31PM +0200, Andrea Arcangeli wrote:
> Ok fine. But first it has to be included into mainline, then of course
> we'll merge it. Fixing Oracle at the expense of being incompatible with
> the user-ABI with future 2.6 is a no-way.

I've come to expect this as a requirement.

The thing I wanted to convey most was that I got an acknowledgment from
the original sources of Oracle's requirement, including the project
lead for the team that maintains statistics collection kit that uses
the statistics to estimate the client capacity of a system and not just
whoever got the bug assigned to them inside Oracle, that Hugh's specific
implementation we want to go with also satisfies the user requirements.
They've even committed to runtime testing the patches to verify the
patch does everything they want it to.


-- wli
