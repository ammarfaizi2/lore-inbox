Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290080AbSBKS7t>; Mon, 11 Feb 2002 13:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290125AbSBKS7j>; Mon, 11 Feb 2002 13:59:39 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:62471 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S290080AbSBKS73>; Mon, 11 Feb 2002 13:59:29 -0500
Subject: Re: 2.4.5 -- Hundreds of compile errors in
	lib/zlib_deflate/deflate.c
From: Miles Lane <miles@megapathdsl.net>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020211075417.GB7960@wizard.com>
In-Reply-To: <1013411533.30864.56.camel@turbulence.megapathdsl.net> 
	<20020211075417.GB7960@wizard.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 11 Feb 2002 10:56:11 -0800
Message-Id: <1013453771.2457.0.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-02-10 at 23:54, A Guy Called Tyketto wrote:
> On Sun, Feb 10, 2002 at 11:12:12PM -0800, Miles Lane wrote:
> > I believe this is a bug in the configuration scripts or data.
> > I ran "make oldconfig" over an older .config file.  If there
> > is a logic error here, oldconfig did not catch it.  Also, 
> > I think I probably enabled these options accidentally when 
> > running "make oldconfig" for 2.4.5-pre6. 
> > 
> > # CONFIG_CRC32 is not set
> > CONFIG_ZLIB_INFLATE=m
> > CONFIG_ZLIB_DEFLATE=m
> > 
> 
>         I hope you are meaning 2.5.4, as CONFIG_ZLIB_DEFLATE, and CONFIG_CRC32 
> are not present in 2.4.5.
> 
>         IIRC, the solution for this was:
> 
> SOURCEDIR=/usr/src/linux
> mv $SOURCEDIR/linux/zutil.h $SOURCEDIR/include/linux
> mv $SOURCEDIR/linux/zconf.h $SOURCEDIR/include/linux
> rmdir $SOURCEDIR/linux

Whoops!  Yes, you are right.  

Thanks a lot,

	Miles

