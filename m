Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTCECY6>; Tue, 4 Mar 2003 21:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTCECY6>; Tue, 4 Mar 2003 21:24:58 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:25229 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267050AbTCECY5>; Tue, 4 Mar 2003 21:24:57 -0500
Date: Tue, 4 Mar 2003 20:35:19 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Chris Wedgwood <cw@f00f.org>
cc: Andrew Morton <akpm@digeo.com>, Daniel Egger <degger@fhm.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bloat 2.4 vs. 2.5
In-Reply-To: <20030305015957.GA27985@f00f.org>
Message-ID: <Pine.LNX.4.44.0303042034230.23375-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Chris Wedgwood wrote:

>     charon:~/wk/linux% size 2.4.x-cw/vmlinux bk-2.5.x/vmlinux
>        text    data     bss     dec     hex filename
>     2003887  120260  191657 2315804  23561c 2.4.x-cw/vmlinux
>     2411323  267551  181004 2859878  2ba366 bk-2.5.x/vmlinux
> 
>     gcc version 2.95.4 20011002 (Debian prerelease)

objdump -h vmlinux gives even more detailed information, which could be 
quite useful. E.g. the increase in data could be __kallsyms, which is a 
config option in 2.5.

--Kai


