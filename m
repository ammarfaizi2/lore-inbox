Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129638AbQK2Bk7>; Tue, 28 Nov 2000 20:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130300AbQK2Bkt>; Tue, 28 Nov 2000 20:40:49 -0500
Received: from jalon.able.es ([212.97.163.2]:53648 "EHLO jalon.able.es")
        by vger.kernel.org with ESMTP id <S129638AbQK2Bkg>;
        Tue, 28 Nov 2000 20:40:36 -0500
Date: Wed, 29 Nov 2000 02:10:25 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
Message-ID: <20001129021025.A768@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <E140urK-0005FZ-00@the-village.bc.nu> <Pine.LNX.4.30.0011281639180.27174-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.30.0011281639180.27174-100000@anime.net>; from goemon@anime.net on Wed, Nov 29, 2000 at 01:39:56 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Nov 2000 01:39:56 Dan Hollis wrote:
> 
> Dont forget the nvidia driver is completely SMP broken. As in, trash your
> filesystems broken.
> 

Not so broken. I use it under SMP 2.2.18-pre23 and works fine. But under 2.4
hangs. So I think it is something that changed between 2.2 and 2.4 (locking
granularity???). And just hangs your box, does not corrupt anything.

It is a pitty that any piece of copylefted code prevents nVivia of giving all
of the drivers in source form.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre23-vm #3 SMP Wed Nov 22 22:33:53 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
