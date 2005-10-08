Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVJHVXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVJHVXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 17:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVJHVXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 17:23:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25095 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751138AbVJHVXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 17:23:53 -0400
Date: Sat, 8 Oct 2005 23:23:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: why is NFS performance poor when decompress linux kernel
Message-ID: <20051008212340.GB25255@alpha.home.local>
References: <4ae3c140510072139n68b9b2eeyc0a400be32d958fe@mail.gmail.com> <1128751189.17981.62.camel@mindpipe> <20051008071936.GF22601@alpha.home.local> <4ae3c140510080735q5842d686u2f023b47f7930586@mail.gmail.com> <4ae3c140510080803x5e58e637u1ea91683628cbf67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140510080803x5e58e637u1ea91683628cbf67@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2005 at 11:03:26AM -0400, Xin Zhao wrote:
> BTW: where did you see that stat is called before each write?

strace

> can you point out the code or function that does this? I might want
> to look into the source code to see whether we can improve it.

What would be cool (if at all possible) would be a command line option
to avoid doing it an rely on the open() return code instead.

Regards,
Willy

