Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVBICeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVBICeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVBICeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:34:25 -0500
Received: from are.twiddle.net ([64.81.246.98]:59777 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261754AbVBICeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:34:02 -0500
Date: Tue, 8 Feb 2005 18:33:46 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: out-of-line x86 "put_user()" implementation
Message-ID: <20050209023346.GA13911@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org> <20050207114415.GA22948@elte.hu> <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org> <20050209012741.GB13802@twiddle.net> <Pine.LNX.4.58.0502081808410.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502081818450.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502081818450.2165@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 06:27:08PM -0800, Linus Torvalds wrote:
> That brings up another issue: if I don't care which registers a 64-bit 
> value goes into, can I get the "low reg" and "high reg" names some way?

Nope.  We never needed one in the i386 backend itself, so we never
added anything like that.


r~
