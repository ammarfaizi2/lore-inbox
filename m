Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWFZUbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWFZUbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFZUbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:31:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750741AbWFZUbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:31:46 -0400
Date: Mon, 26 Jun 2006 13:31:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       hyoshiok@miraclelinux.com
Subject: Re: [PATCH] x86: cache pollution aware __copy_from_user_ll()
In-Reply-To: <p734py7vf20.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.64.0606261328460.3927@g5.osdl.org>
References: <200606231501.k5NF1B79002899@hera.kernel.org>
 <1151160152.3181.59.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0606241218510.6483@g5.osdl.org>
 <p734py7vf20.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jun 2006, Andi Kleen wrote:
> 
> Problem is that it will likely wreck pipe and AF_UNIX (= X server) 
> performance. These read the buffer quickly again.

Look at the patch, dammit!

> If you do something like this it would be better to define
> a special function and use it for real FS traffic only.

Has anybody taken even a five-second look at the patch itself, or are you 
all just complaining without knowing what you're complaining about?

		Linus
