Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUHJM6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUHJM6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUHJM6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:58:13 -0400
Received: from holomorphy.com ([207.189.100.168]:11497 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265093AbUHJM45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:56:57 -0400
Date: Tue, 10 Aug 2004 05:56:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: V13 <v13@priest.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810125651.GV11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, V13 <v13@priest.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com> <200408101552.22501.v13@priest.com> <20040810125140.GU11200@holomorphy.com> <20040810125529.GA22650@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810125529.GA22650@elte.hu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:52:20PM +0300, V13 wrote:
>>> Why don't you create a copy of printk() and start commenting out lines in 
>>> there?

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> This is a very good idea.

On Tue, Aug 10, 2004 at 02:55:29PM +0200, Ingo Molnar wrote:
> i'd guess it's the con->write() in __call_console_drivers() that makes
> the difference. (i.e. touching the framebuffer)

This is serial port IO; would that make the same kind of difference?


-- wli
