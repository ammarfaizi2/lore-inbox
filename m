Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263219AbRFEFDE>; Tue, 5 Jun 2001 01:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263221AbRFEFCy>; Tue, 5 Jun 2001 01:02:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23049 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263219AbRFEFCl>; Tue, 5 Jun 2001 01:02:41 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Reg mkdir syscall
Date: 4 Jun 2001 22:02:23 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9fhp4v$aad$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10106031716330.3971-100000@blrmail> <Pine.LNX.4.10.10106042157410.10477-100000@blrmail>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10106042157410.10477-100000@blrmail>
By author:    "SATHISH.J" <sathish.j@tatainfotech.com>
In newsgroup: linux.dev.kernel
> 
> Actually I had written a small file system(on 2.2.14 kernel) similar  to
> RAMFS on 2.4 kernel. I am able to mount it but when I try to create
> directory under it, it gives EEXIST error saying" file already exists" but
> when I check the directory again that file gets created. But the link
> count of the parent remains the same. I do not know how this directory
> gets created but with an error message. Please also tell me what all
> functions mkdir passes thro' while creating a directory. One more thing is
> when I took an strace of mkdir command the syscall mkdir fails with
> EEXIST error.
> Please help me with your thoughts.
> 

Your code is broken.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
