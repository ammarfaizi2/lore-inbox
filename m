Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVIQM7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVIQM7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVIQM7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:59:44 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:25477 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751101AbVIQM7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:59:43 -0400
Message-ID: <432C132A.8020301@gmail.com>
Date: Sat, 17 Sep 2005 14:59:22 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: sean <seandarcy2@gmail.com>
CC: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: git3 build dies at net/built-in.o: undefined __nfa_fill
References: <dgfp9f$7i8$1@sea.gmane.org>
In-Reply-To: <dgfp9f$7i8$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sean napsal(a):

> On amd64, gcc-4.0.1:
>
> .....
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> net/built-in.o: In function `ip_ct_port_tuple_to_nfattr':
> : undefined reference to `__nfa_fill'
> net/built-in.o: In function `ip_ct_port_tuple_to_nfattr':
> : undefined reference to `__nfa_fill'
> net/built-in.o: In function `tcp_to_nfattr':
> : undefined reference to `__nfa_fill'
> net/built-in.o: In function `icmp_tuple_to_nfattr':
> : undefined reference to `__nfa_fill'
> net/built-in.o: In function `icmp_tuple_to_nfattr':
> : undefined reference to `__nfa_fill'
> net/built-in.o:: more undefined references to `__nfa_fill' follow
> make: *** [.tmp_vmlinux1] Error 1

.config needed
NETFILTER_NETLINK is not selected, maybe.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

