Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315742AbSEJAoI>; Thu, 9 May 2002 20:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSEJAoH>; Thu, 9 May 2002 20:44:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27380 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315742AbSEJAoH>;
	Thu, 9 May 2002 20:44:07 -0400
Date: Thu, 9 May 2002 20:44:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Post, Mark K" <mark.post@eds.com>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Andries.Brouwer@cwi.nl'" <Andries.Brouwer@cwi.nl>,
        "'linux390@ibm.de'" <linux390@ibm.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: kernel mount of initrd fails unless mke2fs uses 1024 byte
  blocks
In-Reply-To: <564DE4477544D411AD2C00508BDF0B6A0C9DD3C2@usahm018.exmi01.exch.eds.com>
Message-ID: <Pine.GSO.4.21.0205092042590.14806-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 May 2002, Post, Mark K wrote:

> Alan, Andries, IBMers,
> 
> Here are the documentation patches that relate to the initrd problem I
> reported previously.  (The mke2fs command had to specify -b 1024, or it
> couldn't be mounted at boot time by the kernel.)  This submission is against
> the 2.4.18 kernel.  If they're acceptable, I'll do another one for the
> 2.2.20 version.

ramdisk_blocksize=<desired block size>

and yes, it's a kludge.

