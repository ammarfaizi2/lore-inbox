Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbULYOMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbULYOMH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 09:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbULYOMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 09:12:06 -0500
Received: from [62.206.217.67] ([62.206.217.67]:63131 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261511AbULYOMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 09:12:03 -0500
Message-ID: <41CD74FE.3090202@trash.net>
Date: Sat, 25 Dec 2004 15:11:10 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Konsar <konsar@brod.pl>
CC: netfilter-devel@lists.netfilter.org,
       netfilter-devel-owner@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
       "David S. Miller" <davem@davemloft.net>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: ip_conntrack_tcp problem on kernel 2.4.28 !!! INVALID ?
References: <opsjkf9pg8or678w@localhost>
In-Reply-To: <opsjkf9pg8or678w@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konsar wrote:
> Hi !!!
> 
> I have patches kernel 2.4.28 + patch-o-matic-ng-20040621 with  
> iptables-1.2.11 on my router/NAT server.This islog from my server
 >
> [...]
>
> Dec 25 14:15:47 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
> (ignored) SRC=64.230.127.202 DST=22.22.22.22 LEN=40 TOS
> =0x00 PREC=0x00 TTL=111 ID=25587 PROTO=TCP SPT=46885 DPT=1804 SEQ=0  
> ACK=881916807 WINDOW=0 RES=0x00 ACK RST URGP=0
> janek.log lines 17-47/47 (END)
> 
> What is this and how close this log ? Where is problem ?

The problem is edonkey, you get all kinds of crap if you run
it or catch the IP of someone who did. Its about the biggest
sin for a network I've ever seen. The only funny part about
it are the crappy implementations, you just have to smile if
you see people do GUI refreshing in the UDP packet handler :)

Regards
Patrick

BTW: No need to CC tons of people for questions like these.
