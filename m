Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVAGXdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVAGXdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVAGXce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:32:34 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:24843 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261700AbVAGX3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:29:37 -0500
Date: Sat, 8 Jan 2005 00:29:32 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-os@analogic.com
Cc: Andries Brouwer <aebr@win.tue.nl>, Ron Peterson <rpeterso@mtholyoke.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/random vs. /dev/urandom
Message-ID: <20050107232932.GC6052@pclin040.win.tue.nl>
References: <20050107190536.GA14205@mtholyoke.edu> <20050107213943.GA6052@pclin040.win.tue.nl> <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 05:39:46PM -0500, linux-os wrote:

> Also, the following shows that the AND operation will destroy
> the randomness of the data. In this case I AND with 1, which
> should produce as many '1's as '0's, ... and clearly does not.

You do not sound like a reliable source of information
about randomness.

> LINUX> gcc -Wall -O2 -o xxx xxx.c
> LINUX> ./xxx
> Trying /dev/random
> 0100000101010000010001000101000000000000000101000100010000000101
>  odds = 14 evens = 18
> Trying /dev/urandom
> 0001010001000100000101000100010001000000000000000000010000000000
>  odds = 10 evens = 22
> LINUX> ./xxx
> Trying /dev/random
> 0100000100010101000101010101010101000100010000010001010000000101
>  odds = 20 evens = 12
> Trying /dev/urandom
> 0100000100000101010001000101010001010001000000010101010100010000
>  odds = 18 evens = 14
