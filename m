Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWKEGSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWKEGSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWKEGSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:18:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161130AbWKEGSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:18:37 -0500
Date: Sat, 4 Nov 2006 22:18:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for
 paravirtualizing critical operations
Message-Id: <20061104221803.3871c3d3.akpm@osdl.org>
In-Reply-To: <200611050646.15334.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org>
	<200611032209.40235.ak@suse.de>
	<1162701815.29777.6.camel@localhost.localdomain>
	<200611050646.15334.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2006 06:46:15 +0100
Andi Kleen <ak@suse.de> wrote:

> 
> > Andi, the patches work against Andrew's tree, and he's merged them in
> > rc4-mm2.  There are a few warnings to clean up, but it seems basically
> > sound.
> > 
> > At this point I our think time is better spent on beating those patches
> > up, rather than going back and figuring out why they don't work in your
> > tree.
> 
> My tree is basically mainline as base. Sure if you don't care about mainline
> merges we can ignore it there and keep it forever in -mm* until Andrew
> gets tired of it?
> 
> That's a possible strategy, but only if you want to keep it as a mm-only
> toy forever.
> 

They're in my regular list-of-thing-to-spam-maintainers-with, so we can
transfer them as-is next week sometime.

It would be better to sort out the various warnings and any other nasties first
though.

