Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbUKVUUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUKVUUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUKVUUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:20:41 -0500
Received: from ozlabs.org ([203.10.76.45]:31461 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262556AbUKVUSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:18:32 -0500
Subject: Re: [2.6 patch] MODULE_PARM_: remove the __deprecated
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041122155619.GG19419@stusta.de>
References: <20041122155619.GG19419@stusta.de>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 07:18:27 +1100
Message-Id: <1101154707.4842.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 16:56 +0100, Adrian Bunk wrote:
> Hi Rusty,
> 
> I know you will not like this patch, but I consider it important since 
> the current beghavior is pretty annoying.

Damn straight.  But I never intended this to happen; this patch was one
of a series.

I went through and fixed up many of them but naturally such a patch was
fragile, huge, and even broke some stuff.

As a result, Andrew dropped the patch, which is fair, but leaves us with
the current state.

I'll go through those patches again today and resent against -mm.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

