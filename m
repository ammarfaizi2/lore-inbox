Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUIBTsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUIBTsC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUIBTsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:48:02 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:28071 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268446AbUIBTrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:47:48 -0400
Date: Thu, 2 Sep 2004 12:47:39 -0700
From: Chris Wedgwood <cw@f00f.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
Message-ID: <20040902194739.GA6673@taniwha.stupidest.org>
References: <20040902192820.GA6427@taniwha.stupidest.org> <20040902193454.GI5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902193454.GI5492@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 12:34:54PM -0700, William Lee Irwin III wrote:

> Please check printk_ratelimit().

I don't want them displayed by default at *all* --- it wakes up the
monitor on console machines and that's annoying.

You get about 1 or 2 a day --- rate limiting isn't useful, nor is
reporting them IMO.


  --cw
