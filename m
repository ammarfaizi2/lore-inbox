Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUG1JYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUG1JYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUG1JYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:24:47 -0400
Received: from holomorphy.com ([207.189.100.168]:3722 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266846AbUG1JYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:24:45 -0400
Date: Wed, 28 Jul 2004 02:24:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: The dreadful CLOSE_WAIT
Message-ID: <20040728092442.GP2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	raul@pleyades.net, linux-kernel@vger.kernel.org
References: <20040727083947.GB31766@DervishD> <20040727160057.GE2334@holomorphy.com> <20040727171025.GA26146@DervishD> <20040727232724.GH2334@holomorphy.com> <20040728090950.GE32254@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728090950.GE32254@DervishD>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 11:09:50AM +0200, DervishD wrote:
>     tcp_fin_timeout is of no help here, since the server is not stuck
> in FIN_WAIT2, and in addition to this, the connection is not closed,
> that is exactly the problem. tcp_max_orphans refer to TCP connections
> not attached to any user file handle, but a connection in state
> CLOSE_WAIT is still attached to a file handle, to a valid one indeed.
>     A grep in the kernel sources didn't give any useful guide about
> which sysctl parameter will help :((
>     Thanks anyway, William :) Maybe tcp_max_orphans can help, don't
> know.

I'd recommend trying various options and seeing if they help at all.


-- wli
