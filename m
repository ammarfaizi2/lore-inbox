Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUERUIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUERUIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUERUIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 16:08:04 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:30198 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263448AbUERUIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 16:08:02 -0400
Date: Tue, 18 May 2004 13:07:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Danny Cox <Danny.Cox@ECWeb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trivial Comment Patch: 2.6.6-mm3
Message-ID: <20040518200742.GA20835@taniwha.stupidest.org>
References: <1084885737.17460.3.camel@vom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084885737.17460.3.camel@vom>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 09:08:57AM -0400, Danny Cox wrote:

> This fixes a comment in the stack overflow check that's wrong with
> 4K stacks.

>  #ifdef CONFIG_DEBUG_STACKOVERFLOW
> -	/* Debugging check for stack overflow: is there less than 1KB free? */
> +	/* Debugging check for stack overflow: is there less than 512B free? */
>  	{
>  		long esp;

akpm, how about just yank the line? the comment's sanity depends on a
CONFIG option and also a value in another file from a far off land.


  --cw
