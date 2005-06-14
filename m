Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVFNGbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVFNGbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVFNGbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:31:55 -0400
Received: from holomorphy.com ([66.93.40.71]:40633 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261243AbVFNGbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:31:53 -0400
Date: Mon, 13 Jun 2005 23:31:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: li nux <lnxluv@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: rmap.c: try_to_unmap_file(): VM_LOCKED not respected
Message-ID: <20050614063150.GI3879@holomorphy.com>
References: <20050614052219.GH3879@holomorphy.com> <20050614054813.63362.qmail@web33314.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614054813.63362.qmail@web33314.mail.mud.yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 10:48:13PM -0700, li nux wrote:
> I first use mmap(MAP_LOCKED) and then
> remap_file_pages.
> This should set VM_LOCKED in the vma.

This is very odd. Could you get a backtrace with code addresses resolved
to line numbers?

When you get backtraces, it should show program counters (EIP's on i386,
RIP's on x86-64, other names on others). If you compile with debugging
symbols and keep the vmlinux, you can use addr2line to resolve them to
addresses. Hopefully this is enough for you to go on.

If you can provide this information, it would be very helpful wrt.
resolving your issue.

Thanks.


-- wli
