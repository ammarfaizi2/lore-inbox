Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbTE1Srn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 14:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTE1Srn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 14:47:43 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:12930
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264782AbTE1Srm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 14:47:42 -0400
Date: Wed, 28 May 2003 14:50:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Torsten Wolf <t.wolf@tu-bs.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 - kernel BUG at page_alloc.c:102!
In-Reply-To: <20030528185615.GA1796@b147.apm.etc.tu-bs.de>
Message-ID: <Pine.LNX.4.50.0305281449450.1982-100000@montezuma.mastecende.com>
References: <20030528185615.GA1796@b147.apm.etc.tu-bs.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Torsten Wolf wrote:

> since I use 2.4.20 (debian source package on Debian testing)
> occasionally the following pops up in my syslog:
> 
> kernel: kernel BUG at page_alloc.c:102!
> kernel: invalid operand: 0000
> kernel: CPU:    0
> kernel: EIP:    0010:[<c0133bc3>]    Tainted: PF
> kernel: EFLAGS: 00013282
>
> This happens both under load (bzip my backup) and in idle periods. The
> system seems to be totally functional after this. Google gave several
> results, where people described the same issue, also with 2.4.20.
> Unfortunately the rare answers were not helpful. What makes the kernel
> tainted are vmware's modules (however, vmware was not running when the
> bug happened) and perhaps Intels e100 driver. lsmod yields the
> following:

I suggest you try and reproduce this one without those modules loaded at 
all.

	Zwane
-- 
function.linuxpower.ca
