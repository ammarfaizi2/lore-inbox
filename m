Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVACWZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVACWZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVACWXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:23:13 -0500
Received: from holomorphy.com ([207.189.100.168]:2719 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261906AbVACWPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:15:22 -0500
Date: Mon, 3 Jan 2005 14:15:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Colin Coe <colin@coesta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Max CPUs on x86_64 under 2.6.x
Message-ID: <20050103221516.GV29332@holomorphy.com>
References: <44438.202.154.120.74.1104760841.squirrel@www.coesta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44438.202.154.120.74.1104760841.squirrel@www.coesta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 10:00:41PM +0800, Colin Coe wrote:
> Why is the number of CPUs on the x86_64 architecture only 8 but under i386
> it is 255?
> I've searched the list archives and Google but can't find an answer.

i386 machines have had interrupt controllers and "large scale" systems
(to the extent that 32-bit machines can be so) developed for some time.
x86-64 machines are newer, and it is the maintainer's preference to
start with a fresh codebase for the APIC.

So what you see is not a reflection of x86-64's capabilities, but
rather, of the newness of the architecture and the codebase's desire
to be "legacy-free" in manners that don't pose the threat of causing
immediate problems.

It is not now limiting the capabilities of x86-64 machines because
x86-64 machines of 64 cpus or larger have yet to be produced. For the
record, I'm unaware of SSI i386 machines larger than 64 processors.
255 represents nothing more than a theoretical limit of hardware
capabilities, and no i386 machine larger than 64 processors has ever
been constructed to the best of my knowledge.


-- wli
