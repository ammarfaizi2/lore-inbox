Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRKDTRN>; Sun, 4 Nov 2001 14:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRKDTRE>; Sun, 4 Nov 2001 14:17:04 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:62636 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273796AbRKDTQv>; Sun, 4 Nov 2001 14:16:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 20:19:39 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160S2o-1JXpD6C@fmrl05.sul.t-online.com> <20011104195955.K14001@unthought.net>
In-Reply-To: <20011104195955.K14001@unthought.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160Skz-1rDDSyC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 November 2001 19:59, you wrote:
> The idea is that if the userland application does it's parsing wrong, it
> should either not compile at all, or abort loudly at run-time, instead of
> getting bad values "sometimes".

All the XML parser interfaces that I have seen so far allow you to do things 
that will cause the code to fail when you do stupid things or are not 
prepared that there may appear unknown elements. Or you use a DTD, and then 
your code is guaranteed to fail after a change, which may be even worse.

One-value-files are a noticable exception, you must be VERY stupid if your 
code breaks because of an additional file.

bye...
