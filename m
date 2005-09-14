Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVINQ6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVINQ6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVINQ6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:58:37 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:48200 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1030280AbVINQ6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:58:37 -0400
Date: Wed, 14 Sep 2005 19:01:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Message-ID: <20050914170107.GB9096@mars.ravnborg.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <4328299C.9020904@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4328299C.9020904@tmr.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The kernel predates C99, sort of, and it would be a massive but valuable 
>  task to figure out where a type is really, for instance, 32 bits 
> rather than "size of default int" in length, etc, and use POSIX types 
> where they are correct. Fewer things to maintain, and would make it 
> clear when something is 32 bits by default and when it really must be 32 
> bits.
This has been discussed several times on lkml.
Ask google...
In short - the kernel provide its own namespace, and here __u32 etc is
used. And starting to change that would be a noisy effort with no or
limited gain neither for the kernel nor userspace.

	Sam
