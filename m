Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbTBPW6T>; Sun, 16 Feb 2003 17:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267807AbTBPW6S>; Sun, 16 Feb 2003 17:58:18 -0500
Received: from port-212-202-184-33.reverse.qdsl-home.de ([212.202.184.33]:57226
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S267806AbTBPW6S>; Sun, 16 Feb 2003 17:58:18 -0500
Message-ID: <3E5019D3.4010609@trash.net>
Date: Mon, 17 Feb 2003 00:08:03 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: yi <yi@ece.utexas.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Getting the value of tcp window size
References: <3E500E52.8050902@ece.utexas.edu>
In-Reply-To: <3E500E52.8050902@ece.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yi wrote:

> Hi,
>
> Using the kernel facility such as system call or something, is there 
> any method of getting the value of tcp window size?
>
> If not, I just want to know whether I have to add a system call of 
> doing that or not.
>
> Thanks.


look at the ss utility which comes with iproute2 in the misc directory. 
it can display lots of information,
other stuff can easily be added to net/ipv4/tcp_diag.c.

Bye,
Patrick

