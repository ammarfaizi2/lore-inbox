Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310212AbSCLAF3>; Mon, 11 Mar 2002 19:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310223AbSCLAFK>; Mon, 11 Mar 2002 19:05:10 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:1270 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310212AbSCLAE7>; Mon, 11 Mar 2002 19:04:59 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020311234516.GC128921@niksula.cs.hut.fi> 
In-Reply-To: <20020311234516.GC128921@niksula.cs.hut.fi>  <4394.1015887380@kao2.melbourne.sgi.com> 
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zlib vulnerability and modutils 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Mar 2002 00:04:53 +0000
Message-ID: <14719.1015891493@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vherva@niksula.hut.fi said:
>  Is there a patch for the kernel ppp zlib implementation available
> somewhere? I'd like to patch the kernels I'm running rather than
> stuffing a random vendor kernel to the boxes... 

ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/linux-2.4.19-shared-zlib.bz2

That's a backport of the shared zlib from 2.5.6. As it does all its 
memory allocation beforehand, I _assume_ it doesn't suffer the same problem.

It may be a little more intrusive than you wanted though.

--
dwmw2


