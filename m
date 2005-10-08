Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVJHHOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVJHHOT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 03:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVJHHOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 03:14:19 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:34457 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750829AbVJHHOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 03:14:18 -0400
Date: Sat, 8 Oct 2005 09:14:16 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: sasa.ostrouska@volja.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.6.14-rc3
Message-ID: <20051008091416.6038ebaa@localhost>
In-Reply-To: <1128731551.8004.2.camel@rc-vaio.rcdiostrouska.com>
References: <1128731551.8004.2.camel@rc-vaio.rcdiostrouska.com>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2005 02:32:31 +0200
Sasa Ostrouska <sasa.ostrouska@volja.net> wrote:

> Oct  8 02:20:33 rc-vaio kernel: EIP:    0060:[<c01eac19>]    Tainted: P

http://www.tux.org/lkml/#s1-18

"Some vendors distribute binary modules (i.e. modules without available
source code under a free software license). As the source is not freely
available, any bugs uncovered whilst such modules are loaded cannot be
investigated by the kernel hackers. All problems discovered whilst such
a module is loaded must be reported to the vendor of that module, not
the Linux kernel hackers and the linux-kernel mailing list. The
tainting scheme is used to identify bug reports from kernels with
binary modules loaded: such kernels are marked as "tainted" by means of
the MODULE_LICENSE tag. If a module is loaded that does not specify an
approved license, the kernel is marked as tainted. The canonical list
of approved license strings is in linux/include/linux/module.h. "oops"
reports marked as tainted are of no use to the kernel developers and
will be ignored. A warning is output when such a module is loaded. Note
that you may come across module source that is under a compatible
license, but does not have a suitable MODULE_LICENSE tag. If you see a
warning from modprobe or insmod for a module under a compatible
license, please report this bug to the maintainers of the module, so
that they can add the necessary tag."

-- 
	Paolo Ornati
	Linux 2.6.14-rc3-gc0758146 on x86_64
