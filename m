Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWEON7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWEON7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWEON7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:59:30 -0400
Received: from addr-213-139-163-144.baananet.fi ([213.139.163.144]:52621 "EHLO
	asalmela.iki.fi") by vger.kernel.org with ESMTP id S964911AbWEON73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:59:29 -0400
Date: Mon, 15 May 2006 16:59:27 +0300
From: Antti Salmela <asalmela@iki.fi>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/vmscan.c:428 (2.6.17-rc4-git2, Dualcore AMD x86-64)
Message-ID: <20060515135926.GA13151@asalmela.iki.fi>
References: <20060515082508.GA6950@asalmela.iki.fi> <44683F05.5050709@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44683F05.5050709@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 06:42:45PM +1000, Nick Piggin wrote:
> Either you have an active page on the inactive list, or your hardware has
> flipped a bit in page->flags. I was going to say the latter is more likely,
> however -- AFAIKS, the first oops should cause that page to be lost from the
> LRU list, so the second oops shouldn't happen if the flip a single bad bit,
> and should be pretty unlikely if it is a random error.

Thanks, I thought I had run memtest86 long enough when I bought the
system, but now it found one stuck bit almost immediately. 

-- 
Antti Salmela
