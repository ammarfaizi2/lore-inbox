Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSKYIpT>; Mon, 25 Nov 2002 03:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbSKYIpT>; Mon, 25 Nov 2002 03:45:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:39173 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262692AbSKYIpS>;
	Mon, 25 Nov 2002 03:45:18 -0500
Date: Mon, 25 Nov 2002 09:52:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Zaffiro <davzaffiro@netscape.net>
Cc: willy@w.ods.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling x86 with and without frame pointer
Message-ID: <20021125085229.GA15592@alpha.home.local>
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121050607.GA1554@mark.mielke.cc> <3DDCA7C9.9040501@netscape.net> <20021121192045.GE3636@alpha.home.local> <3DE1E384.8000801@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DE1E384.8000801@netscape.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Anyway it makes me wonder, whether kernelcompilation shouldn't be 
> configurable between a "optimize for (compressed image) size" and a 
> "optimize for speed" option... I'd go for speed... (and always omitting 
> frame-pointers doesn't seem to as fast as omitting them only in leaf 
> functions).

hehe :-)
I've put this in my kernels for about 2 years now. You can also reduce the
image size with -malign-jumps=0 -mpreferred-stack-boundary=2 and -mcpu=i386.

I also use some other options, but don't have them at hand right now. But it
basically gives me slightly smaller kernels, which is pretty good for install
CD or diskettes.

Cheers,
Willy
