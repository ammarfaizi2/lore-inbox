Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265848AbRGLPUL>; Thu, 12 Jul 2001 11:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbRGLPUB>; Thu, 12 Jul 2001 11:20:01 -0400
Received: from groupw1.ethz.ch ([129.132.97.47]:15620 "EHLO groupw1.ethz.ch")
	by vger.kernel.org with ESMTP id <S265975AbRGLPTq>;
	Thu, 12 Jul 2001 11:19:46 -0400
From: Giacomo Catenazzi <cate@debian.org>
To: Emmanuel Varagnat <varagnat@crm.mot.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <3B4DBFC9.4040108@debian.org>
Date: Thu, 12 Jul 2001 17:18:33 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.1) Gecko/20010607 Netscape6/6.1b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
Subject: Re: Makefile problem and modules
In-Reply-To: <fa.fo00suv.1ug283k@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Varagnat wrote:

> I wrote a module for IPv6 but there is a case when it is
> compiled.
> (For the moment my code can only work as a module...)
> When IPv6 is compiled as a module, my module is well compiled.
> But if IPv6 is directly in the kernel, my module is not take
> into account (I've got no object file).
> 
> Here is the only line I added to the Makefile (near the end):
> 
> obj-$(CONFIG_IPV6_MYSTUFF)  += mystuff.o
> 

Changes in the Config.in file?


	giacomo
