Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUHFFTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUHFFTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 01:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268093AbUHFFTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 01:19:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:8345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267765AbUHFFTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 01:19:12 -0400
Date: Thu, 5 Aug 2004 22:17:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-Id: <20040805221734.69597956.akpm@osdl.org>
In-Reply-To: <20040806043915.GT17188@holomorphy.com>
References: <20040805031918.08790a82.akpm@osdl.org>
	<20040806033448.GP17188@holomorphy.com>
	<20040806042420.GS17188@holomorphy.com>
	<20040806043915.GT17188@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, Aug 05, 2004 at 08:34:48PM -0700, William Lee Irwin III wrote:
>  >> It appears that init_idle() and fork_by_hand() could be combined into
>  >> a single method that calls init_idle() on behalf of the caller, which
>  >> would amount to something like:
>  >> task_t * __init fork_idle(int cpu)
> 
>  On Thu, Aug 05, 2004 at 09:24:20PM -0700, William Lee Irwin III wrote:
>  > Atop the full 2.6.8-rc3-mm1 series:
> 
>  Fix up sparc32 properly (incremental).

Well I had to significantly smash these patches to get stuff in the right
place.  Please check that next -mm has it all right.

