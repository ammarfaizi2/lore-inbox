Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265715AbUFXV1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUFXV1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265696AbUFXV1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:27:44 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:60375 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S265676AbUFXV0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:26:06 -0400
Date: Thu, 24 Jun 2004 17:26:00 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware
Message-ID: <20040624212600.GW728@washoe.rutgers.edu>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040624191026.GP728@washoe.rutgers.edu> <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua> <20040624202626.GS728@washoe.rutgers.edu> <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 11:58:55PM +0300, Denis Vlasenko wrote:
> Do a

> # strace -p 1501

> and you'll se what's going on

can you please help me to understand the dump?

time strace -p 2586
Process 2586 attached - interrupt to quit
brk(0)                                  = 0x8dff000
brk(0x8e21000)                          = 0x8e21000
brk(0)                                  = 0x8e21000
brk(0x8e43000)                          = 0x8e43000
brk(0)                                  = 0x8e43000
brk(0x8e65000)                          = 0x8e65000
brk(0)                                  = 0x8e65000
brk(0x8e87000)                          = 0x8e87000
brk(0)                                  = 0x8e87000
brk(0x8ea9000)                          = 0x8ea9000
brk(0)                                  = 0x8ea9000
brk(0x8ecb000)                          = 0x8ecb000
brk(0)                                  = 0x8ecb000
brk(0x8eed000)                          = 0x8eed000
brk(0)                                  = 0x8eed000
brk(0x8f0f000)                          = 0x8f0f000
brk(0)                                  = 0x8f0f000
brk(0x8f30000)                          = 0x8f30000
brk(0)                                  = 0x8f30000
brk(0x8f52000)                          = 0x8f52000
Process 2586 detached

real    0m6.927s
user    0m0.032s
sys     0m0.004s

if I dump longer than the rest kinda flies so it is slows down just
after
open("/var/lib/dpkg/available", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=12398100, ...}) = 0
mmap2(NULL, 12398100, PROT_READ, MAP_SHARED, 4, 0) = 0x40157000
brk(0)                                  = 0x840e000
brk(0x8430000)                          = 0x8430000
brk(0)                                  = 0x8430000
....

I will check once more when it 'delays'

-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

