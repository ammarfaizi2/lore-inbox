Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTACKjt>; Fri, 3 Jan 2003 05:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTACKjt>; Fri, 3 Jan 2003 05:39:49 -0500
Received: from holomorphy.com ([66.224.33.161]:2761 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267484AbTACKjs>;
	Fri, 3 Jan 2003 05:39:48 -0500
Date: Fri, 3 Jan 2003 02:48:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd phenomenon.
Message-ID: <20030103104809.GD9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030103103816.GA2567@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103103816.GA2567@codemonkey.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 10:38:16AM +0000, Dave Jones wrote:
> Something strange I've noticed on all recent 2.4 and 2.5 kernels.
> If I start galeon whilst I've got a bk pull in operation, the
> galeon process starts, opens its window, and then dies instantly.
> Starting it a second time works.
> Its not OOM, as theres plenty of free RAM, and half gig of free (unused) swap.
> It's almost 100% reproducable here.  Only seen it do it on this box
> though which is a P4 with HT, so it could be SMP related..
> Ideas ?
> 		Dave

(1) strace?
(2) kgdb breakpoint on exit(), conditional on current->comm?
(3) exit code?


Thanks,
Bill
