Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266378AbUHIWp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266378AbUHIWp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUHIWp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:45:59 -0400
Received: from holomorphy.com ([207.189.100.168]:40419 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266378AbUHIWp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:45:56 -0400
Date: Mon, 9 Aug 2004 15:45:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040809224546.GZ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809211042.GY11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 12:53:23PM -0700, William Lee Irwin III wrote:
>>> I can reproduce here (ia64/Altix). Fixing.

On Mon, Aug 09, 2004 at 01:43:57PM -0700, William Lee Irwin III wrote:
>> It comes up with the following applied. Now distilling into a bugfix.

On Mon, Aug 09, 2004 at 02:10:42PM -0700, William Lee Irwin III wrote:
> The following does *NOT* come up. The difference appears to be the delay
> from the printk()'s.

Adding mdelay(1000) before and after the wakeup IPI didn't help. Must
be something else going on in printk().


-- wli
