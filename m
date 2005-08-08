Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVHHVz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVHHVz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVHHVz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:55:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932280AbVHHVz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:55:56 -0400
Date: Mon, 8 Aug 2005 14:54:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       hugh@veritas.com, torvalds@osdl.org, andrea@suse.de,
       benh@kernel.crashing.org
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Message-Id: <20050808145430.15394c3c.akpm@osdl.org>
In-Reply-To: <200508090724.30962.phillips@arcor.de>
References: <42F57FCA.9040805@yahoo.com.au>
	<200508090710.00637.phillips@arcor.de>
	<200508090724.30962.phillips@arcor.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> 'Scuse me:
> 
> On Tuesday 09 August 2005 07:09, Daniel Phillips wrote:
> > Suggestion for your next act:
> 
> ...kill PG_checked please :)  Or at least keep it from spreading.
> 

It already spread - ext3 is using it and I think reiser4.  I thought I had
a patch to rename it to PG_misc1 or somesuch, but no.  It's mandate becomes
"filesystem-specific page flag".

