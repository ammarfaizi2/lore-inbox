Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUBJTXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbUBJTXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:23:04 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:25599 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S266034AbUBJTWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:22:36 -0500
Date: Tue, 10 Feb 2004 12:22:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@suse.cz>,
       akpm@osdl.org, george@mvista.com, Andi Kleen <ak@suse.de>,
       jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040210192234.GL5219@smtp.west.cox.net>
References: <20040127184029.GI32525@stop.crashing.org> <20040209155013.GF5219@smtp.west.cox.net> <20040209173828.GG2315@waste.org> <200402101327.40378.amitkale@emsyssoft.com> <20040210084605.GA27889@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210084605.GA27889@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 08:46:05AM +0000, Dave Jones wrote:
> On Tue, Feb 10, 2004 at 01:27:40PM +0530, Amit S. Kale wrote:
>  > http://www.codemonkey.org.uk/projects/bitkeeper/kgdb/kgdb-2004-02-10.diff
>  > has grown over 10MB. Something wrong in generating a diff?
> 
> More likely mainline got ahead of the kgdb patch.

That's true.  I've stuck on 2.6.2-rc2 just because I'm, er, lazy.

> http://www.codemonkey.org.uk/projects/bitkeeper/kgdb/ is a diff
> generated using bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
> 
> It's a tenth of the size. Look better ?

That looks about right (and much of that is the netpoll stuff).

-- 
Tom Rini
http://gate.crashing.org/~trini/
