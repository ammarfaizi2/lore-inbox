Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbSKQMNP>; Sun, 17 Nov 2002 07:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbSKQMNP>; Sun, 17 Nov 2002 07:13:15 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:61882 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267491AbSKQMNP>;
	Sun, 17 Nov 2002 07:13:15 -0500
Date: Sun, 17 Nov 2002 23:19:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tomita@cinet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: PC-9800 on 2.5.47-ac5
Message-Id: <20021117231933.0a40d319.sfr@canb.auug.org.au>
In-Reply-To: <1037494049.24777.37.camel@irongate.swansea.linux.org.uk>
References: <3DD6DADC.F5BE96E6@cinet.co.jp>
	<1037494049.24777.37.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Nov 2002 00:47:28 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> Thanks - I'm trying to fold bits in one at a time and to avoid lots of
> messy ifdefs. BTW - have you tested the APM change as it seems to have
> more pushes than pops for the stack ?

I assumed that the PC-9800 must be using an iret instead of ret to get
back from the APM BIOS.  This is, of course, broken ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
