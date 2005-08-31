Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVHaWSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVHaWSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVHaWSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:18:04 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:55006 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964938AbVHaWSC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:18:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k0fm7tdmECx5DtuHq5o23JoehSRV4FySHi3Y6JPMpv3vhHI73Q1gn3wVeSODdZBreKDE3AqmhxZXFs+8ZaMngPNGh7D5IDH4LRTiBTcou7wCWDK9zE8VjLS7mhwi3bFhTpynW30ckJyNzU+4jzThDBz2/jDFPxyDuc8RnEKW16Y=
Message-ID: <9a8748490508311518320c6aba@mail.gmail.com>
Date: Thu, 1 Sep 2005 00:18:01 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andrew Morton <akpm@osdl.org>, SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050831221424.GA14806@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>
	 <20050831215757.GA10804@taniwha.stupidest.org>
	 <431628D5.1040709@zytor.com>
	 <20050831220717.GA14625@taniwha.stupidest.org>
	 <9a874849050831151230d68d64@mail.gmail.com>
	 <20050831221424.GA14806@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Sep 01, 2005 at 12:12:00AM +0200, Jesper Juhl wrote:
> 
> > b) add a new boot option telling the kernel the name of some file in
> > initrd or similar from which to load additional options.
> 
> a file in initrd isn't a good choice; as the initrd is generally a fix
> image
> 
> the point is some bootloaders might want to pass quite a bit of state
> to the kernel at times (i actually have this for a mip32 target where
> i construct a table and pass a pointer to that in, a tad icky but for
> lack of options)
> 
Well, it wouldn't have to be initrd specifically. Generally what's
needed is *some* way to tell the kernel "please read more options from
location <foo>". The interresting bit is what <foo>'s supposed to be.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
