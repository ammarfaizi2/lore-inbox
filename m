Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318050AbSGLWve>; Fri, 12 Jul 2002 18:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318051AbSGLWvd>; Fri, 12 Jul 2002 18:51:33 -0400
Received: from holomorphy.com ([66.224.33.161]:43423 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318050AbSGLWvb>;
	Fri, 12 Jul 2002 18:51:31 -0400
Date: Fri, 12 Jul 2002 15:53:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: NUMA-Q breakage 5/7 in_interrupt() race
Message-ID: <20020712225318.GA21551@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rml@tech9.net
References: <20020712224003.GC25360@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020712224003.GC25360@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 03:40:03PM -0700, William Lee Irwin III wrote:
> On smaller machines, bootstrapping proceeds far enough to see races
> in kmaps near generic_file_read() etc. This is precisely the
> in_interrupt() BUG(), but it's quite clear this is happening in
> process context. Not even the smaller machines can survive this.
> That is, it is impossible to run at all without it (or an equivalent).
> Robert, please apply.

Argh, I forgot to credit Rusty Russell (and possibly also Paul Mackerras)
with originally discovering & fixing this.


Cheers,
Bill
