Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWFBGDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWFBGDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFBGDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:03:50 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:56004 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751203AbWFBGDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:03:49 -0400
Date: Fri, 2 Jun 2006 01:57:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.16-rc5-mm2] i386 memcpy: optimal memcpy for IO
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606020201_MC3-1-C166-4742@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <447FC75F.6090905@zytor.com>

On Thu, 01 Jun 2006 22:06:39 -0700, H. Peter Anvin wrote:

> Why wrap this in C code when it's just assembly anyway?  It just makes 
> it look ugly...

Because I couldn't figure out how to do EXPORT_SYMBOL for assembler
code. :|

And the C compiler handles frame pointers and CONFIG_REGPARM
automatically, so that made the code simpler.

-- 
Chuck

