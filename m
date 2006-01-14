Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWANRu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWANRu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWANRu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:50:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750723AbWANRu4 (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 14 Jan 2006 12:50:56 -0500
Date: Sat, 14 Jan 2006 09:50:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch] mm: cleanup bootmem
In-Reply-To: <43C8F198.3010609@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0601140949460.13339@g5.osdl.org>
References: <43C8F198.3010609@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jan 2006, Nick Piggin wrote:
>
> Objections?

The whole point of the pre-batching was that apparently the non-batched 
bootmem code took ages to boot in simulation with lots of memory. I think 
it was the ia64 people who used simulation a lot. So..

		Linus
