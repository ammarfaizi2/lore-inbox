Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279143AbRJZUQO>; Fri, 26 Oct 2001 16:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279144AbRJZUQB>; Fri, 26 Oct 2001 16:16:01 -0400
Received: from lsd.nurk.org ([208.8.184.53]:9868 "HELO lsd.nurk.org")
	by vger.kernel.org with SMTP id <S279143AbRJZUPu>;
	Fri, 26 Oct 2001 16:15:50 -0400
Date: Fri, 26 Oct 2001 13:17:02 -0700 (PDT)
From: Sean Swallow <sean@swallow.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3Com PCI 3c905C Tornado with later kernels
In-Reply-To: <3BD9B86A.E9BF474F@mandrakesoft.com>
Message-ID: <Pine.LNX.4.40.0110261313170.1175-100000@lsd.nurk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,

Configuring CONFIG_NETLINK_DEV and CONFIG_RTNETLINK in the kernel solved
my problem. In the kernel help it says that NETLINK_DEV will be removed
soon... Will Donald's drivers still work when it's removed?

Thanks again Jeff,

-- 
Sean J. Swallow
pgp (6.5.2) keyfile @ https://nurk.org/keyfile.txt


On Fri, 26 Oct 2001, Jeff Garzik wrote:

> Sean Swallow wrote:
> >
> > List,
> >
> > I am having a problem with a 3c905C and later kernels (2.4.9, 2.4.12 and
> > 2.4.13).  When I try to use my 3c905C with these kernels I get this error
> > message:
> >
> > Cannot open netlink socket: Address family not supported by protocol
> >
> > Kernel 2.4.7 works fine with this nic tho. I also tried this on another
> > machine with the same results.
>
> Did you upgrade your initscripts by any chance?
>
> Turn on CONFIG_NETLINK_DEV in your kernel config.
>
>

