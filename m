Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132853AbRDXH72>; Tue, 24 Apr 2001 03:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132855AbRDXH7T>; Tue, 24 Apr 2001 03:59:19 -0400
Received: from juicer13.bigpond.com ([139.134.6.21]:18911 "EHLO
	mailin1.bigpond.com") by vger.kernel.org with ESMTP
	id <S132853AbRDXH7G>; Tue, 24 Apr 2001 03:59:06 -0400
Message-Id: <m14ruux-001PJtC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pedantic code cleanup - am I wasting my time with this? 
In-Reply-To: Your message of "Mon, 23 Apr 2001 17:26:27 +0200."
             <3AE449A3.3050601@eisenstein.dk> 
Date: Tue, 24 Apr 2001 14:59:15 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3AE449A3.3050601@eisenstein.dk> you write:
>          return (waitall ? len : min(sk->rcvlowat, len)) ? : 1;
> 
> To be strictly correct the second expression (between '?' and ':' ) 
> should not be omitted (all you guys already know that ofcourse).

It's a GCC extension.  From Documentation/DocBook/kernel-hacking.tmpl:

    GNU Extensions are explicitly allowed in the Linux kernel.

Rusty.
--
Premature optmztion is rt of all evl. --DK
