Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319601AbSIHMuy>; Sun, 8 Sep 2002 08:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319602AbSIHMuy>; Sun, 8 Sep 2002 08:50:54 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:8198 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S319601AbSIHMux>; Sun, 8 Sep 2002 08:50:53 -0400
Date: Sun, 8 Sep 2002 22:55:24 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Performance issue in 2.5.32+
In-Reply-To: <m38z2cy9qc.fsf@averell.firstfloor.org>
Message-ID: <Mutt.LNX.4.44.0209082254330.20891-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Sep 2002, Andi Kleen wrote:

> 2.5.32 added the TLS changes, which do rewrite the GDT in context switch.
> Does it go away when you comment out the call to load_TLS in 
> arch/i386/kernel/process.c:__switch_to() ?

Nope, the lmbench results look roughly the same.


- James
-- 
James Morris
<jmorris@intercode.com.au>


