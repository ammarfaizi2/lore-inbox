Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSHBTkO>; Fri, 2 Aug 2002 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSHBTkO>; Fri, 2 Aug 2002 15:40:14 -0400
Received: from pop.gmx.de ([213.165.64.20]:14124 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316845AbSHBTkM>;
	Fri, 2 Aug 2002 15:40:12 -0400
Date: Fri, 2 Aug 2002 21:43:42 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Booting problem, 2.4.19-rc5-ac1, ali15x3
Message-Id: <20020802214342.55e50f02.gigerstyle@gmx.ch>
In-Reply-To: <3D4ACEC4.3050601@turbolinux.co.jp>
References: <9cfu1mp5kru.fsf@rogue.ncsl.nist.gov>
	<9cfd6t1nwuh.fsf@rogue.ncsl.nist.gov>
	<20020802171218.016b3d70.gigerstyle@gmx.ch>
	<3D4ACEC4.3050601@turbolinux.co.jp>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I haven't tried the patch yet, but I think it won't help in my case, because it is Ali-chipset related.
My Sony Vaio GR114EK has an Intel (i810 or i820) chipset. I think it's a more general problem.
I hope it will help.

marc

On Sat, 03 Aug 2002 03:26:12 +0900
Go Taniguchi <go@turbolinux.co.jp> wrote:

> Hi,
> 
> Please apply and test this patch.
> Probably pci_config_byte 0x79 is vendor specifics.
> Newer japanese hardware which use ALi IDE with Crusoe got hang up.
> 
> This patch will solve the following problems without option 'ide0=ata66 ide1=ata66'
> 
