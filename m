Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281074AbRKDS0V>; Sun, 4 Nov 2001 13:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKDS0L>; Sun, 4 Nov 2001 13:26:11 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:42192 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281076AbRKDSZ7>; Sun, 4 Nov 2001 13:25:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 19:27:16 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104172742Z16629-26013+37@humbolt.nl.linux.org> <20011104184159.E14001@unthought.net>
In-Reply-To: <20011104184159.E14001@unthought.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160RwJ-2D3EHoC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 November 2001 18:41, you wrote:
> The "fuzzy parsing" userland has to do today to get useful information
> out of many proc files today is not nice at all. 

I agree, but you dont need a binary format to achieve this. A WELL-DEFINED 
format is sufficient. XML is one of them, one-value-files another one. The 
"fuzzy parsing" only happens because the files try to be friendly for human 
readers.


> It eats CPU, it's error-prone, and all in all it's just "wrong".

How much of your CPU time is spent parsing /proc files?


> However - having a human-readable /proc that you can use directly with
> cat, echo,  your scripts,  simple programs using read(), etc.   is
> absolutely a *very* cool feature that I don't want to let go.  It is just
> too damn practical.

You shouldn't use them in scripts because they are likely to break. That's 
the whole point. At least not when you want to distribute the scripts to 
others. And BTW the one-value-files are much easier to parse for scripts than 
any other solution that I have seen so far, including the current /proc 
interface.

bye...
