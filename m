Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTHTHqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbTHTHqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:46:40 -0400
Received: from holomorphy.com ([66.224.33.161]:63107 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261732AbTHTHqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:46:39 -0400
Date: Wed, 20 Aug 2003 00:47:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm3
Message-ID: <20030820074749.GG4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030819013834.1fa487dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819013834.1fa487dc.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 01:38:34AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm3/
> . More CPU scheduler changes
> . The regression with reaim which was due to the CPU scheduler changes
>   seems to have largely gone away, but it was never a large effect in my
>   testing.  Needs retesting please.
> . A series of Cardbus driver updates.

Looks good. There are some ACPI bits to clean up after, but with the
preliminary ACPI workarounds and the cyclone timer one-liner, 16x/64GB
x440's come up and run userspace just fine with XKVA enabled (haven't
bothered with NUMA-Q since the setup there is inconvenient for others).
I think it was all wrapped up by the combination of the pmd and TSS
fixes (at least to get these boxen going).


-- wli
