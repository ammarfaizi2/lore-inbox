Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUIBUAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUIBUAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUIBUAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:00:16 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:29436 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268860AbUIBT7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:59:37 -0400
Date: Thu, 2 Sep 2004 12:59:28 -0700
From: Chris Wedgwood <cw@f00f.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
Message-ID: <20040902195928.GA6834@taniwha.stupidest.org>
References: <20040902192820.GA6427@taniwha.stupidest.org> <20040902193454.GI5492@holomorphy.com> <20040902194739.GA6673@taniwha.stupidest.org> <20040902195219.GJ5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902195219.GJ5492@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 12:52:19PM -0700, William Lee Irwin III wrote:

> That's okay. The reason why is that this is in response to an
> external stimulus which can, in principle, scream out of control, so
> even at KERN_DEBUG or other loglevels it's meaningful to rate limit
> it.

If you have enough to be a problem something is wrong and you're dead
already.  For such cases a more generic interrupt throttling approach
is required.


  --cw
