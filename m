Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbTJAFr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbTJAFr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:47:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:60132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261951AbTJAFr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:47:57 -0400
Date: Tue, 30 Sep 2003 22:48:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: jun.nakajima@intel.com, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata
 patch
Message-Id: <20030930224853.15073447.akpm@osdl.org>
In-Reply-To: <20031001053833.GB1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com>
	<20031001053833.GB1131@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> Nakajima, Jun wrote:
> > Yes. It would kind to tell the pilot about the errata of the engine (and
> > refuse to start), rather than telling him that the engine might break
> > down anytime after the takeoff.
> 
> Doesn't refusing to boot seem to heavy handed for this bug?  The buggy
> CPUs have been around for many years (it is practically the entire AMD
> line for the last 4 years or so), and nobody in userspace has
> complained about the 2.4 behaviour so far.  (Linux 2.4 behaviour is,
> of course, to ignore the errata).

That is the case at present.  But the 2.6 kernel was hitting this
erracularity daily.

If some smart cookie decides to add prefetches to some STL implementation
or something, they are likely to start hitting it with the same frequency.


