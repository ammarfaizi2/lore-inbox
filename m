Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWITWbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWITWbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWITWbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:31:22 -0400
Received: from khc.piap.pl ([195.187.100.11]:63148 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932418AbWITWbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:31:21 -0400
To: sergio@sergiomb.no-ip.org
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au, billm@suburbia.net
Subject: Re: Math-emu kills the kernel on Athlon64 X2
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	<1158623391.13821.4.camel@localhost.portugal>
	<m3fyeof3c7.fsf@defiant.localdomain>
	<1158713320.3098.15.camel@localhost.portugal>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 21 Sep 2006 00:31:16 +0200
In-Reply-To: <1158713320.3098.15.camel@localhost.portugal> (Sergio Monteiro Basto's message of "Wed, 20 Sep 2006 01:48:40 +0100")
Message-ID: <m3bqpa6uh7.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> writes:

> Btw I try install a kernel 2.4 in my DX2 and works but very very slow .
> I think in this type of computer should be install a kernel 2.2 . 

I think it's a RAM problem. Most 386DX and early 486 boards allowed
32 MB (using 4 MB modules),  Linux 2.6 should run fine on such
a beast (386SX was limited to 16 MB address space). Later 486 boards
using DIMMs, I think, supported 64 MB (with caching).

Of course a "6 bogomips" 386 CPU isn't a speed daemon but in early
1990s it wasn't any faster and people were using them commonly (and,
I think, comfortably). IMHO for basic "SOHO Internet server" (mail
and such) it could be fast enough running Linux 2.6.
-- 
Krzysztof Halasa
