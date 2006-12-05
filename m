Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967538AbWLEFml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967538AbWLEFml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967528AbWLEFml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:42:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57438 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967484AbWLEFmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:42:40 -0500
Date: Mon, 4 Dec 2006 21:42:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061204214229.2070548a.akpm@osdl.org>
In-Reply-To: <17781.27.369430.322758@cargo.ozlabs.ibm.com>
References: <20061204204024.2401148d.akpm@osdl.org>
	<17781.27.369430.322758@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 16:14:03 +1100
Paul Mackerras <paulus@samba.org> wrote:

> > radix-tree-rcu-lockless-readside.patch
> > 
> >  There's no reason to merge this yet.
> 
> We want to use it in some powerpc arch code.  Currently we use a
> per-cpu array of spinlocks, and this patch would let us get rid of
> that array.

ok, let's merge it then.
