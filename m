Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289216AbSA1P0U>; Mon, 28 Jan 2002 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289218AbSA1P0I>; Mon, 28 Jan 2002 10:26:08 -0500
Received: from mnh-1-25.mv.com ([207.22.10.57]:42756 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S289216AbSA1PZ6>;
	Mon, 28 Jan 2002 10:25:58 -0500
Message-Id: <200201281528.KAA01717@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1 
In-Reply-To: Your message of "Mon, 28 Jan 2002 02:30:04 PST."
             <3C55282C.7D607CFB@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Jan 2002 10:28:08 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@zip.com.au said:
> - If a function is very small (20-30 bytes) then inlining
>   is correct even if it has many call sites. 

- Or if it collapses to something very small due to constant propogation
and other optimizations.

Maybe this was intended, but I think it's worth making it explicit.

				Jeff

