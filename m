Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289957AbSAKOEe>; Fri, 11 Jan 2002 09:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289959AbSAKOEY>; Fri, 11 Jan 2002 09:04:24 -0500
Received: from mail.turbolinux.co.jp ([210.171.55.67]:13831 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id <S289957AbSAKOEM>; Fri, 11 Jan 2002 09:04:12 -0500
Message-ID: <3C3EF0AC.6010505@turbolinux.co.jp>
Date: Fri, 11 Jan 2002 23:03:24 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
Organization: Turbolinx Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:0.9.6) Gecko/20011206
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: sd@turbolinux.co.jp, "David S. Miller" <davem@redhat.com>
Subject: Re: [sd:04032] Re: [PATCH] removed socket buffer in unix domain socket
In-Reply-To: <E16NaD0-0001Hs-00@the-village.bc.nu>	<3C3EE76C.1030808@turbolinux.co.jp> <20020111.054525.107941129.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your comment.

>    
> Slot 256 is a special slot fo unbound sockets.  The table is
> sized to UNIX_HASH_SIZE + 1, so it is ok and your patch is
> not right.
> 
> Please see the other email from Alexey Kuznetsov which includes
> a real fix for your bug.
> 
> 

OK, however that fix can not work the test program.
The problem always occurred by process of slot 256.
I try to confirm the "real fix" once again.

Thanx.

