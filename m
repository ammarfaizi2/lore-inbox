Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282860AbRLVW1t>; Sat, 22 Dec 2001 17:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282866AbRLVW1i>; Sat, 22 Dec 2001 17:27:38 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:53175 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282860AbRLVW1X>; Sat, 22 Dec 2001 17:27:23 -0500
Message-ID: <3C250835.9010806@wanadoo.fr>
Date: Sat, 22 Dec 2001 23:24:53 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: fr, en
MIME-Version: 1.0
To: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
In-Reply-To: <20011222164602.A20623@Sophia.soo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

really mason_at_soo_dot_com wrote:

> Running kernel 2.5.2-pre1 compiled with gcc 3.0.3,
> i get the following error irregularly when starting
> X or trying to compile sawfish in an xterm:
> 
> Inconsistency detected by ld.so: dynamic-link.h: 62: elf_get_dynamic_info: Assertion `! "bad dynamic tag"' failed!


I've also seen sawfish seg-faulting at the first try of 2.5.2-pre1.

 
> Have no idea what it means, and it doesn't happen
> under any earlier 2.5.X kernels using the same
> compiler.
> 
> Am also using binutils-2.11.2 and glibc-2.2.4.


The same here (but gcc-2.95.3). I re-compiled sawfish, while running 
2.4.17, with 2.4.17 headers in /usr/include/asm and /usr/include/linux 
and it works again.


Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

