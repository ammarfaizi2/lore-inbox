Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285181AbRLRVOg>; Tue, 18 Dec 2001 16:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285174AbRLRVN0>; Tue, 18 Dec 2001 16:13:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:5905 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285161AbRLRVMk>; Tue, 18 Dec 2001 16:12:40 -0500
Date: Tue, 18 Dec 2001 17:57:54 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Momchil Velikov <velco@fadata.bg>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <87bsgwi6zz.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.21.0112181757460.4821-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 18 Dec 2001, Momchil Velikov wrote:

> >>>>> "Marcelo" == Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> Marcelo> Momchil, 
> 
> Marcelo> Your fix does not look right. We _have_ to sync pages at
> Marcelo> sync_page_buffers(), we cannot "ignore" them.
> 
> Sure, we don't ignore them, we just don't _wait_ for them, because
> maybe _we_ are the one to write them.  

What if we are not ? 

