Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSGIAO1>; Mon, 8 Jul 2002 20:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSGIAO0>; Mon, 8 Jul 2002 20:14:26 -0400
Received: from jalon.able.es ([212.97.163.2]:48542 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317280AbSGIAOZ>;
	Mon, 8 Jul 2002 20:14:25 -0400
Date: Tue, 9 Jul 2002 02:17:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.19-rc1 doesn't link
Message-ID: <20020709001701.GE1948@werewolf.able.es>
References: <Pine.LNX.4.44.0207081803250.10105-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0207081803250.10105-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Tue, Jul 09, 2002 at 02:05:17 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.09 Thunder from the hill wrote:
>Hi,
>
>On Mon, 8 Jul 2002, Richard Gooch wrote:
>> init/do_mounts.o: In function `rd_load_image':
>> init/do_mounts.o(.text.init+0x941): undefined reference to `change_floppy'
>> init/do_mounts.o: In function `rd_load_disk':
>> init/do_mounts.o(.text.init+0xa9b): undefined reference to `change_floppy'
>> make: *** [vmlinux] Error 1
>
>Strange thing. All three are #ifdef CONFIG_BLK_DEV_RAM, so if you enable 
>BLK_DEV_RAM, you get all three. Do you have CONFIG_BLK_DEV_FD enabled?
>

Known bug. Try:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-rc1-jam1/02-blk-dev-ram.bz2

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
