Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRJABfW>; Sun, 30 Sep 2001 21:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274427AbRJABfM>; Sun, 30 Sep 2001 21:35:12 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:16644 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S274426AbRJABfA>;
	Sun, 30 Sep 2001 21:35:00 -0400
Message-ID: <3BB7C8AA.9060703@si.rr.com>
Date: Sun, 30 Sep 2001 21:36:42 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: fdavis@si.rr.com
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.10-ac1: undefined reference to rpc_queue_lock
In-Reply-To: <3BB7C7F6.5040600@si.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    rpc_queue_lock is referenced in net/sunrpc/sched.c and net/sunrpc/xprt.c

Regards,
Frank

Frank Davis wrote:

> Hello,
>     While building 2.4.10-ac1, I received the following:
> ......
>     -o vmlinux
> net/network.o: In function 'udp_data_ready'
> net/network.o(.text+0x56ebc): undefined reference to 'rpc_queue_lock'
> net/network.o(.text+0x56ec2): undefined reference to 'rpc_queue_lock'
> net/network.o(.text+0x56f62): undefined reference to 'rpc_queue_lock'
> net/network.o(.text+0x56f82): undefined reference to 'rpc_queue_lock'
> net/network.o(.text+0x56fa2): undefined reference to 'rpc_queue_lock'
> net/network.o(.text+0x5731e): more undefined references to 
> 'rpc_queue_lock' follow
> make: *** [vmlinux] Error 1
> 
> 


