Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTLSN4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 08:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTLSN4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 08:56:14 -0500
Received: from holomorphy.com ([199.26.172.102]:7575 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263057AbTLSNzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 08:55:51 -0500
Date: Fri, 19 Dec 2003 05:55:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.6.0 on IBM 600X
Message-ID: <20031219135541.GP31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>,
	linux-kernel@vger.kernel.org
References: <pan.2003.12.19.13.22.08.801900@interlinx.bc.ca> <20031219132806.GO31393@holomorphy.com> <1071842015.5759.64.camel@pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071842015.5759.64.camel@pc>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 08:28, William Lee Irwin III wrote:
>> devfs is not really in a state to be used (maybe it should be removed);
>> could you try without?

On Fri, Dec 19, 2003 at 08:53:36AM -0500, Brian J. Murrell wrote:
> The same kernels that cause this problem on my IBM laptop do not cause
> the same problems on my desktop Athlon 800 (Thunderbird) machine, so
> this has to be some strange interaction with this hardware, no?
> In any case, with a devfs enabled kernel booted with "devfs=nomount"
> causes the same problem.
> A non-devfs enabled kernel no error message regarding devfs and no stack
> trace from it, but I still get an oops:
> hdc: CRN-8241B, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Unable to handle kernel NULL pointer dereference at virtual address 00000008
[...]
> EIP is at sysfs_hash_and_remove+0x8/0x69

This one we can do something about. Looking into it.


-- wli
