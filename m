Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWFRHhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWFRHhY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWFRHgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:36:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18617 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932158AbWFRHgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:36:25 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: x86_64: x86-64 mailing lists / posting patchkits / x86-64 releases
Date: Sun, 18 Jun 2006 09:35:35 +0200
User-Agent: KMail/1.9.3
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <200606121307.54556.ak@suse.de> <20060617100543.ae21d6d9.akpm@osdl.org>
In-Reply-To: <20060617100543.ae21d6d9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606180935.35977.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >From the below, a lot of the problems I'm having to fix are simply x86
> build/link/depmod breakage.

It's unfortunate - my testing is definitely focussed on x86-64, but
often the same problem(s) exist in i386 too and of course it has 
to be changed there too.

> So more careful build checking on x86-32 would 
> improve things quite a lot.

I'm already doing it a bit, but one problem is that i386 has a lot 
more build variants than x86-64. I'll try to do better.

BTW I've been actually considering to reduce the variants a bit - e.g. I think
it doesn't make sense anymore to allow x86 kernels without APIC support
(it can be still disabled at runtime with default set by a config).  

-Andi
