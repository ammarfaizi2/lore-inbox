Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278958AbRJZTYH>; Fri, 26 Oct 2001 15:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278980AbRJZTXy>; Fri, 26 Oct 2001 15:23:54 -0400
Received: from mail020.mail.bellsouth.net ([205.152.58.60]:10957 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278958AbRJZTXm>; Fri, 26 Oct 2001 15:23:42 -0400
Message-ID: <3BD9B86A.E9BF474F@mandrakesoft.com>
Date: Fri, 26 Oct 2001 15:24:26 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Swallow <sean@swallow.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3Com PCI 3c905C Tornado with later kernels
In-Reply-To: <Pine.LNX.4.40.0110261142110.1175-100000@lsd.nurk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Swallow wrote:
> 
> List,
> 
> I am having a problem with a 3c905C and later kernels (2.4.9, 2.4.12 and
> 2.4.13).  When I try to use my 3c905C with these kernels I get this error
> message:
> 
> Cannot open netlink socket: Address family not supported by protocol
> 
> Kernel 2.4.7 works fine with this nic tho. I also tried this on another
> machine with the same results.

Did you upgrade your initscripts by any chance?

Turn on CONFIG_NETLINK_DEV in your kernel config.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

