Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUCJIDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbUCJIDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:03:43 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:58888 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262525AbUCJIC0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:02:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Sasidhar Mukkmalla" <msreddy@guardiansolutions.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Oops and crashes
Date: Wed, 10 Mar 2004 09:52:42 +0200
X-Mailer: KMail [version 1.4]
References: <006301c40619$1cbaa6c0$6a00a8c0@reddy>
In-Reply-To: <006301c40619$1cbaa6c0$6a00a8c0@reddy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403100952.42522.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 March 2004 22:57, Sasidhar Mukkmalla wrote:
> Hi,
> We have many servers running with Intel 2.4GHz processor on ATX MBD 845E
> chipset. These machines have 512MB ram and two hard drives of 200GB. All
> are raided at level 1.
>
> Our systems crash often and these are the messages I got from logs from two
> different instances of crashes. Both these logs are from the same machine.
> Any help to fix these problems would be greatly appreciated. Thank you

Kernel version? lsmod? lspci? .config?

> LOG 1
>
> Feb 19 16:12:10 DVRS10-3 kernel: Unable to handle kernel paging request at
> virtual address 2524
> 1f1f
> Feb 19 16:12:10 DVRS10-3 kernel:  printing eip:
> Feb 19 16:12:10 DVRS10-3 kernel: c013a181
> Feb 19 16:12:10 DVRS10-3 kernel: *pde = 00000000
> Feb 19 16:12:10 DVRS10-3 kernel: Oops: 0002
> Feb 19 16:12:10 DVRS10-3 kernel: softdog parport_pc lp parport
> iptable_filter ip_tables autofs
> bttv soundcore i2c-algo-bit i2c-core videodev e100 sg sr_mod microcode
> ide-scsi scsi_mod ide-cd

Do you really need all these modules in _server_ ?

> Feb 19 16:12:10 DVRS10-3 kernel: CPU:    0
> Feb 19 16:12:10 DVRS10-3 kernel: EIP:    0060:[<c013a181>]    Tainted: GF

What taints your kernel?
--
vda
