Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVLZSeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVLZSeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLZSeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:34:50 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:1121 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932083AbVLZSeu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:34:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TZiUZILsxNiu5BEDDdbZGX4UQ6MXdVO+V8XJeh0284m142VBtp9dEdHpE8e/vI8W2hVQPzVtehO35siIpv5kd/DB4lmtSYwsW6fo1WjNrbZCImlnp8n7JbqskCuliLM1xVmxwCDOt1r0Hn4qhSdifiu4dzrSaTC08GsJ1UVsDdg=
Message-ID: <84144f020512261034q356b4484sa6e6528e339e67f5@mail.gmail.com>
Date: Mon, 26 Dec 2005 20:34:46 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] SLAB - have index_of bug at compile time.
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0512261209060.9622@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B01BD7.3040209@colorfullife.com>
	 <Pine.LNX.4.58.0512261209060.9622@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 12/26/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> Now, maybe NUMA and vmalloc might be a good reason to start a new
> allocation system along side of slab?

A better approach would probably be to introduce a vmem layer similar
to what Solaris has to solve I/O memory and vmalloc issue. What NUMA
issue are you referring to btw? I don't see any problem with the
current design (in fact, I stole it for my magazine allocator too).
It's just that the current implementation is bit hard to understand.

                         Pekka
