Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUASAla (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 19:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbUASAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 19:41:30 -0500
Received: from are.twiddle.net ([64.81.246.98]:27793 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S264308AbUASAl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 19:41:29 -0500
Date: Sun, 18 Jan 2004 16:41:16 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute
Message-ID: <20040119004116.GA32149@twiddle.net>
Mail-Followup-To: Andi Kleen <ak@colin2.muc.de>,
	Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
	Andrew Morton <akpm@osdl.org>, jh@suse.cz,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org> <20040115074834.GA38796@colin2.muc.de> <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org> <20040116101345.GA96037@colin2.muc.de> <20040118204700.GA31601@twiddle.net> <20040118205800.GA68521@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118205800.GA68521@colin2.muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 09:58:00PM +0100, Andi Kleen wrote:
> Hmpf. Would an extable_compare() function in an asm-*/ file work ? 

I'd need a swap function too, since the data itself must change
when it gets moved.


r~
