Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261927AbSIYHJD>; Wed, 25 Sep 2002 03:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261928AbSIYHJD>; Wed, 25 Sep 2002 03:09:03 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19972 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261927AbSIYHJC>; Wed, 25 Sep 2002 03:09:02 -0400
Message-Id: <200209250709.g8P79ip29724@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: DragonK <dragon_krome@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.4.x Bug
Date: Wed, 25 Sep 2002 10:04:05 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020924213421.22776.qmail@web20307.mail.yahoo.com>
In-Reply-To: <20020924213421.22776.qmail@web20307.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 September 2002 19:34, DragonK wrote:
> I'm sorry if I'm sending this to the wrong persons,
> but I really don't know whom I should send this to.
>
> My problem involves ALL linux kernels 2.4.x. All
> versions I've tried on my machine lock up at boot time
> (no panic, no oops, just plain old dead), just after
> writing "Uncompressing linux kernel...Ok, now booting
> the kernel...". The kernel banner DOES NOT appear. I
> compiled every kernel with a minimal set of options
> (and CPU=386) but nothing; I've even installed the
> latest Lilo.

I'd compile 2.2 and 2.4 kernels with most conservative settings,
put them on a diskettes and try at several PCs.
No, not a full Linux, just a kernel. 

That way you can collect some data as to which PCs do
not like 2.4

Also you can stick debugging in the early boot stages
and investigate.

<shameless plug>

If you have/can install DOS, you may use this bootloader
for debugging. It is small and source is easy to understand
(I hope)

http://www.imtp.ilyichevsk.odessa.ua/linux/vda/linld/

You need *devel.tar* file only if you don't have Borland C,
otherwise take much smaller linld095.tar.bz2

</shameless plug>
--
vda
