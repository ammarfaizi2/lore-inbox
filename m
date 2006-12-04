Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759780AbWLDE7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759780AbWLDE7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 23:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759796AbWLDE7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 23:59:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:4789 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759780AbWLDE7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 23:59:52 -0500
Date: Sun, 3 Dec 2006 20:59:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: <Aucoin@Houston.RR.com>
Cc: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: Re: la la la la ... swappiness
Message-Id: <20061203205947.a0cf92e5.akpm@osdl.org>
In-Reply-To: <200612040154.kB41sadx019068@ms-smtp-03.texas.rr.com>
References: <200612040154.kB41sadx019068@ms-smtp-03.texas.rr.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006 19:54:41 -0600
"Aucoin" <Aucoin@Houston.RR.com> wrote:

> What, if anything, besides manually echoing a "3" to drop_caches will cause
> all those inactive pages to be put back on the free list ?

There is no reason for the kernel to do that - a clean, inactive page is
immediately reclaimable on demand.
