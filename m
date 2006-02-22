Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161288AbWBVCK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161288AbWBVCK5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWBVCK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:10:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932542AbWBVCK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:10:56 -0500
Date: Tue, 21 Feb 2006 18:09:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kiran@scalex86.org, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-Id: <20060221180912.09a76013.akpm@osdl.org>
In-Reply-To: <43FBB441.1010209@yahoo.com.au>
References: <20060220233242.GC3594@localhost.localdomain>
	<43FA8938.70006@yahoo.com.au>
	<20060221202024.GA3635@localhost.localdomain>
	<43FBB441.1010209@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> But my point still stands that it never makes sense to add empty space into
>  a hash table. Add hash slots instead and you (for free) get shorter hash
>  chains.

OK, not an accident ;)
