Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312734AbSDBATG>; Mon, 1 Apr 2002 19:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312735AbSDBAS5>; Mon, 1 Apr 2002 19:18:57 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48138 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312734AbSDBASt>; Mon, 1 Apr 2002 19:18:49 -0500
Date: Mon, 1 Apr 2002 20:13:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Thomas Michael Wanka <Thomas@Wanka.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 highmem smp freeze
In-Reply-To: <3CA7CD94.27390.74FD378@localhost>
Message-ID: <Pine.LNX.4.21.0204012013260.8498-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Apr 2002, Thomas Michael Wanka wrote:

> Hi,
> 
> here are some people (including me) with smp and more than 1GB Ram 
> (most Serverworks chipsets, have not jet seen it with AMDs MPX) where 
> after some time (from hours to weeks probably load dependent) it 
> seems there is nothing written to disk anymore and in the end the 
> system completely freezes. This with several 2.4.x kernels (2.4.4, 
> 2.4.10, 2.4.16, 2.4.17 and 2.4.18).
> 
> I think this has been discussed here, but I am too stupid to 
> understand it and/or find the solution.
> 
> I browsed the archives of the last year, and I think it was suggested 
> to use 2.4.17rc2aa1 or aa2. Is this correct and will it solve the 
> problem (IIRC there was no success message)? Will the later 2.2 
> kernels show this behavior too (like 2.2.20)?

The ServerWorks chipsets are problematic. Use the "noapic" boot option.



