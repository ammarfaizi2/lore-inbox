Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSHJKzr>; Sat, 10 Aug 2002 06:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSHJKzr>; Sat, 10 Aug 2002 06:55:47 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:41992 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316845AbSHJKzq>; Sat, 10 Aug 2002 06:55:46 -0400
Date: Sat, 10 Aug 2002 12:59:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
In-Reply-To: <9131.1028945953@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0208101247170.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Aug 2002, Keith Owens wrote:

> Adding a constant prefix to every label and string will increase the
> size of the kernel.  I would much rather find a way for cpp to strip
> quotes from a #define, then -DKBUILD_OBJECT=\"unix\" has no problems.
> But I don't know any cpp construct to convert KBUILD_OBJECT ("unix") to
> bare 'unix' without the quotes.  Undefining conflicting names is tacky
> but it has the least (zero) impact on the kernel size.

I think prepending an underscore would also be an acceptable solution. The
size increase is minimal and it's easy to remove from the stringified
name.

bye, Roman

