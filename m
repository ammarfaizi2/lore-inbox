Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUIBTfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUIBTfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIBTfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:35:08 -0400
Received: from holomorphy.com ([207.189.100.168]:60623 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268346AbUIBTe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:34:58 -0400
Date: Thu, 2 Sep 2004 12:34:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
Message-ID: <20040902193454.GI5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20040902192820.GA6427@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902192820.GA6427@taniwha.stupidest.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 12:28:20PM -0700, Chris Wedgwood wrote:
> i386 hardware can (and does) see spurious interrupts from time to
> tome.  Ideally I would like the printk removed completely but this is
> probably good enough for now.

Please check printk_ratelimit().


-- wli
