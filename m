Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316040AbSEJPxN>; Fri, 10 May 2002 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316041AbSEJPxN>; Fri, 10 May 2002 11:53:13 -0400
Received: from parmenides.zen.co.uk ([212.23.8.69]:6670 "HELO
	parmenides.zen.co.uk") by vger.kernel.org with SMTP
	id <S316040AbSEJPxL>; Fri, 10 May 2002 11:53:11 -0400
Message-ID: <3CDBED93.3040508@treblig.org>
Date: Fri, 10 May 2002 16:56:03 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: dizzy@roedu.net, linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
In-Reply-To: <Pine.LNX.4.33.0205101832080.9661-100000@ahriman.bucharest.roedu.net> <20020510.083050.55863714.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Mihai RUSU <dizzy@roedu.net>
>    Date: Fri, 10 May 2002 18:37:21 +0300 (EEST)
>    
>    PS: why signal(SIGBUS,SIG_IGN) doesnt work, but a user handler its called
>    if set with signal(SIGBUS,handle_sigbus) ?
> 
> How would you like the kernel to "ignore" a page fault that cannot be
> serviced?

Well imagining you really wanted to do it you could skip a store 
instruction or put a dummy value in the register that something is being 
loaded into.

Dave

