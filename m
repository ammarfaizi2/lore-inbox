Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269231AbUIQWeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269231AbUIQWeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbUIQWd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:33:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:42933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269231AbUIQWby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:31:54 -0400
Date: Fri, 17 Sep 2004 15:35:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Cumming <ryan@spitfire.gotdns.org>
Cc: andrea@novell.com, stelian@popies.net, hugh@veritas.com,
       bruce@andrew.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040917153526.26cc4084.akpm@osdl.org>
In-Reply-To: <200409171514.38316.ryan@spitfire.gotdns.org>
References: <20040917154834.GA3180@crusoe.alcove-fr>
	<200409171454.02531.ryan@spitfire.gotdns.org>
	<20040917220039.GD15426@dualathlon.random>
	<200409171514.38316.ryan@spitfire.gotdns.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming <ryan@spitfire.gotdns.org> wrote:
>
> How does this look?
> 
>  ...
> +static inline unsigned long __attribute_pure__ roundup_pow_of_two(int x)
> +{
> +	return (1UL << fls(x));
> +}

Any reason for making the argument an integer, rather than unsigned long?
