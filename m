Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVJXOJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVJXOJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 10:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVJXOJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 10:09:33 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:54656 "EHLO dipsaus.vs19.net")
	by vger.kernel.org with ESMTP id S1751044AbVJXOJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 10:09:33 -0400
Date: Mon, 24 Oct 2005 16:09:20 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051024140920.GA6561@spaans.vs19.net>
References: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
X-Copyright: Copyright 2005 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

On Mon, Oct 24, 2005 at 01:48:38AM -0700, Andrew Morton wrote:
> +clean-crypto-sha1c-up-a-bit.patch
> 
>  crypto cleanup

It seems this one breaks sha1 (on my AMD Sempron); quoting dmesg:

testing sha1
test 1:
9c80d0f72a11fe6f3919c20ced200a71ea6a9a93
fail
test 2:
ac94a4c354401d31f6642a6d53fe732c0cdca39a
fail
testing sha1 across pages
test 1:
ac94a4c354401d31f6642a6d53fe732c0cdca39a
fail


Cheers,
-- 
Jasper Spaans                                       http://jsp.vs19.net/
 16:03:17 up 10477 days,  6:50, 0 users, load average: 5.00 5.19 6.10
