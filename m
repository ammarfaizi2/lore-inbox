Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292905AbSBZVmw>; Tue, 26 Feb 2002 16:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293070AbSBZVmn>; Tue, 26 Feb 2002 16:42:43 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:4751 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S292905AbSBZVm3>;
	Tue, 26 Feb 2002 16:42:29 -0500
Date: Tue, 26 Feb 2002 21:40:55 GMT
Message-Id: <200202262140.g1QLet111256@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: crypto (was Re: Congrats Marcelo,)
In-Reply-To: <1014759355.1109.31.camel@phantasy>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1014759355.1109.31.camel@phantasy> you wrote:
> Besides IPsec, what crypto is there for the kernel?  I've never really
> understood what "crypto in the kernel means" since it all should be a
> userspace thing.

loopback mount crypto. you want the actual crypts in kernel to avoid 2
context switches per block you read.

