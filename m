Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVBWSd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVBWSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVBWSd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:33:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:3555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261528AbVBWSdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:33:54 -0500
Date: Wed, 23 Feb 2005 10:34:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Olof Johansson <olof@austin.ibm.com>, Joe Korty <joe.korty@ccur.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
In-Reply-To: <20050223182203.GA10931@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0502231033540.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org>
 <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
 <20050223144940.GA880@tsunami.ccur.com> <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org>
 <20050223171015.GD10256@austin.ibm.com> <20050223182203.GA10931@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Feb 2005, Jamie Lokier wrote:
> 
> I suggest putting it into futex.c, and make it an inline function
> which takes "u32 __user *".

Agreed, except we've traditionally just made it "int __user *".

		Linus
