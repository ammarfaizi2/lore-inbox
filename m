Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281817AbRLLTqk>; Wed, 12 Dec 2001 14:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281818AbRLLTqb>; Wed, 12 Dec 2001 14:46:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281817AbRLLTqY>; Wed, 12 Dec 2001 14:46:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IP -> hostname lookup in kernel module?
Date: 12 Dec 2001 11:46:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9v8c61$gcn$1@cesium.transmeta.com>
In-Reply-To: <1008174218.3c17848ab4b69@home.hjc.edu.sg> <Pine.LNX.4.33.0112130035070.2697-100000@localhost.localdomain> <20011212173517.G17064@blu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011212173517.G17064@blu>
By author:    antirez <antirez@invece.org>
In newsgroup: linux.dev.kernel
> 
> There isn't, but you can create an UDP socket and to the query..
> 

No you can't.  There is no way that you can find out which nameservers
are configured.

> or run an userspace resolver daemon that talks with your
> module, or some other trick.
> 
> BTW it isn't the kind of stuff to do in kernelspace.
> You may think about do it in a post-processing stage
> if possible, or to write a module that exports to userspace
> what you need from the kernel and do the rest in userspace.

Indeed.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
