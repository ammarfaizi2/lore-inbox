Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSEWOAq>; Thu, 23 May 2002 10:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316694AbSEWOAp>; Thu, 23 May 2002 10:00:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:11973 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316693AbSEWOAo>; Thu, 23 May 2002 10:00:44 -0400
Date: Thu, 23 May 2002 15:03:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Mike Black <mblack@csihq.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: page_alloc bug in 2.4.17-pre8
In-Reply-To: <036901c2025f$0746e2f0$f6de11cc@black>
Message-ID: <Pine.LNX.4.21.0205231500250.1196-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002, Mike Black wrote:
> Oops -- got the wrong version (head was in the wrong kernel space).
> This occurred on 2.4.19-pre8

Then page_alloc.c:108 is a different check from what you showed, it's

	if (page->mapping)
		BUG();

I know nothing of that one, sorry.

Hugh

