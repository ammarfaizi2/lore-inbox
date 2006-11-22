Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967055AbWKVDo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967055AbWKVDo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 22:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967061AbWKVDo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 22:44:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:16579 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967055AbWKVDo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 22:44:56 -0500
Date: Tue, 21 Nov 2006 19:44:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
In-Reply-To: <20061122032512.GE533@redhat.com>
Message-ID: <Pine.LNX.4.64.0611211944120.3352@woody.osdl.org>
References: <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
 <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
 <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
 <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org> <20061122032512.GE533@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Nov 2006, Dave Jones wrote:
>
> ITYM...
> 
> memset(buf, 0, SIZE);

I'm just checking that you're paying attention.

There's a reason sparse warns about the third parameter of a memset() 
being zero ;)

		Linus
