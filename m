Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269273AbUIBXTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269273AbUIBXTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUIBXTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:19:40 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:4011 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269273AbUIBXST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:18:19 -0400
Date: Thu, 2 Sep 2004 19:18:15 -0400
From: Tom Vier <tmv@comcast.net>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902231815.GC15505@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <20040826032457.21377e94.akpm@osdl.org> <742303812.20040826125114@tnonline.net> <20040826035500.00b5df56.akpm@osdl.org> <1453776111.20040826131547@tnonline.net> <20040826042043.15978b0a.akpm@osdl.org> <20040826112938.GK2612@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826112938.GK2612@wiggy.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:29:38PM +0200, Wichert Akkerman wrote:
> That is actually one of the few places where a bit of metadata would be
> very useful. Right now there is no way to indicate in what encoding a
> source is written: ascii, utf-8, ucs16, etc. are all possible. But a
> compiler or interpreter has no good way to figure that out.

Make it a cmd line option. The makefile can contain info on what files are
what and invoke the right options.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
