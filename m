Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTIHRu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTIHRu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:50:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15535 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263444AbTIHRu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:50:26 -0400
Date: Mon, 8 Sep 2003 18:51:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
In-Reply-To: <Pine.LNX.4.44.0309081746180.7008-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309081849580.7061-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Hugh Dickins wrote:
> 
> In part 5, the Jenkins hashing, I was puzzled by the "/4" in
> +			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
> [much blabbering snipped]

Sorry, I've just read that and noticed "sizeof": rosy dawn of enlightenment.

Hugh

