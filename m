Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVBKWPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVBKWPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVBKWPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:15:35 -0500
Received: from hera.kernel.org ([209.128.68.125]:63188 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262369AbVBKWPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:15:21 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: out-of-line x86 "put_user()" implementation
Date: Fri, 11 Feb 2005 22:15:04 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cujap8$ta$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502081808410.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502081818450.2165@ppc970.osdl.org> <20050209023346.GA13911@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1108160104 939 127.0.0.1 (11 Feb 2005 22:15:04 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 11 Feb 2005 22:15:04 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050209023346.GA13911@twiddle.net>
By author:    Richard Henderson <rth@twiddle.net>
In newsgroup: linux.dev.kernel
>
> On Tue, Feb 08, 2005 at 06:27:08PM -0800, Linus Torvalds wrote:
> > That brings up another issue: if I don't care which registers a 64-bit 
> > value goes into, can I get the "low reg" and "high reg" names some way?
> 
> Nope.  We never needed one in the i386 backend itself, so we never
> added anything like that.
> 

I would really like to see that feature.  I've missed it more than a
few times.

	-hpa
