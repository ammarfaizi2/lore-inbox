Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSKIQaJ>; Sat, 9 Nov 2002 11:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSKIQaJ>; Sat, 9 Nov 2002 11:30:09 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59128 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261663AbSKIQaI>; Sat, 9 Nov 2002 11:30:08 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0211081843010.5564-100000@home.transmeta.com> 
References: <Pine.LNX.4.44.0211081843010.5564-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: mmap(PROT_READ, MAP_SHARED) fails if !writepage. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Nov 2002 16:36:49 +0000
Message-ID: <27126.1036859809@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dwmw2@infradead.org said:
> Suggested patch below.... or should I just hack fsx-linux to use
> MAP_PRIVATE for its readonly mappings and ignore it? 


torvalds@transmeta.com said:
>  You have two choices: make  gratuitous changes to the kernel to make
> some random test happy, or fix  the test.

> I think you should fix the test. The kernel change buys you _zero_ new
>  features.

Works for me. Thanks for the answer.

--
dwmw2


