Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266328AbUA2TpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266330AbUA2TpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:45:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:2221 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266328AbUA2Tob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:44:31 -0500
Date: Thu, 29 Jan 2004 11:44:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
In-Reply-To: <20040129193727.GJ21888@waste.org>
Message-ID: <Pine.LNX.4.58.0401291142160.689@home.osdl.org>
References: <20040129193727.GJ21888@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jan 2004, Matt Mackall wrote:
> 
> a) (no -psl)
> 
> void *foo(void) {
> 
>  instead of
> 
> void *
> foo(void) {

And why not 

	void *foo(void)
	{

which is the _right_ thing to use?

> b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
> c) (-ncs) "(void *)foo" rather than "(void *) foo"

Hmm.. I don't know about (c), that one tends to vary by usage.

		Linus
