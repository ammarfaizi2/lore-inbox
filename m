Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273731AbSISWxw>; Thu, 19 Sep 2002 18:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273732AbSISWxw>; Thu, 19 Sep 2002 18:53:52 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:30056 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S273731AbSISWxv>; Thu, 19 Sep 2002 18:53:51 -0400
Date: Fri, 20 Sep 2002 09:00:35 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Gustavo Lozano <glozano@noldata.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel message:   kernel: memory: cbc1eee0  what is?
In-Reply-To: <1032477981.1256.2.camel@Grissom>
Message-ID: <Pine.LNX.4.05.10209200857230.23877-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 2002, Gustavo Lozano wrote:

> Hello
> 
> My 2.4.19 box today showed these 2 messages:
> 
> Hostname: kernel: memory: cbc1eee0
> Hostname: kernel: memory: cbc1ef60
> 
> 
> What is the signifance of such messages?

Hmm... you *sure* it wasn't "memory :" (note space before colon)?

If so, might be agpgart_fe's ambiguious printk (and disgustingly normal).
I'll post a patch RSN.

HTH,
Neale.

