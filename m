Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131187AbRBVWlg>; Thu, 22 Feb 2001 17:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131125AbRBVWlS>; Thu, 22 Feb 2001 17:41:18 -0500
Received: from jalon.able.es ([212.97.163.2]:16862 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130298AbRBVWlD>;
	Thu, 22 Feb 2001 17:41:03 -0500
Date: Thu, 22 Feb 2001 23:40:52 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac1
Message-ID: <20010222234052.A2995@werewolf.able.es>
In-Reply-To: <E14VxLb-0004Nd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14VxLb-0004Nd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 22, 2001 at 16:07:57 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.22 Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
>

Patching 2.4.2:

patching file include/linux/raid/md_k.h
Hunk #1 succeeded at 17 with fuzz 2 (offset 2 lines).

I think it's because the line:

18: #include <linux/kernel.h>

is already present, and patch tries to add it again, so the result is:

18: #include <linux/kernel.h>
19:
20: #include <linux/kernel.h>   // for panic()


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2 #1 SMP Thu Feb 22 11:40:37 CET 2001 i686

