Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135173AbRDLMxY>; Thu, 12 Apr 2001 08:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135176AbRDLMxF>; Thu, 12 Apr 2001 08:53:05 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:49415 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135173AbRDLMwy>;
	Thu, 12 Apr 2001 08:52:54 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: info <css@sniip.ru>
Date: Thu, 12 Apr 2001 14:52:04 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Repeating 2.4.3 compile error with ipx makefile patch
CC: linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>
X-mailer: Pegasus Mail v3.40
Message-ID: <4C0B72839C7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Apr 01 at 12:49, info wrote:
>         /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> net/network.o(.data+0x2c84): undefined reference to `sysctl_ipx_pprop_broadcasting' 

Yes. This error is already fixed in 2.4.3-ac4, as I already wrote. Use newer
kernel or compile IPX as module. I believe that it is fixed in 2.4.4-pre2 
too. Patch I sent fixed compilation with disabled CONFIG_SYSCTL. As
I use zerocopy patches from Alan tree, I cannot create tested patch
for Linus tree (and I try to avoid creation of untested patches)...
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
                                                    
