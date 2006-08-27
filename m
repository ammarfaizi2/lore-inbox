Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWH0CmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWH0CmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 22:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWH0CmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 22:42:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9226 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750917AbWH0CmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 22:42:20 -0400
Date: Sun, 27 Aug 2006 04:42:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       coreteam@netfilter.org
Subject: 2.6.18-rc4-mm3: NF_CONNTRACK_FTP=y compile error
Message-ID: <20060827024219.GO4765@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm2:
>...
>  git-net.patch
>...
>  git trees
>...

<--  snip  -->

...
  CC      net/netfilter/nf_conntrack_ftp.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c: In function ‘get_ipv6_addr’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c:117: warning: implicit declaration of function ‘in6_pton’
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c:117: error: ‘end’ undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c:117: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c:117: error: for each function it appears in.)
make[3]: *** [net/netfilter/nf_conntrack_ftp.o] Error 1

<--  snip  -->
 
cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

