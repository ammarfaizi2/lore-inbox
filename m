Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266400AbRGYBWh>; Tue, 24 Jul 2001 21:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbRGYBWa>; Tue, 24 Jul 2001 21:22:30 -0400
Received: from jalon.able.es ([212.97.163.2]:22711 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S266400AbRGYBWV>;
	Tue, 24 Jul 2001 21:22:21 -0400
Date: Wed, 25 Jul 2001 03:26:34 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: GOTO Masanori <gotom@debian.or.jp>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 tmpfs strange behaviour
Message-ID: <20010725032634.A1175@werewolf.able.es>
In-Reply-To: <20010725005940.A5607@werewolf.able.es> <w53bsm9c06f.wl@megaela.fe.dis.titech.ac.jp> <20010725025014.A2431@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010725025014.A2431@werewolf.able.es>; from jamagallon@able.es on Wed, Jul 25, 2001 at 02:50:14 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 20010725 J . A . Magallon wrote:
>
>On 20010725 GOTO Masanori wrote:
>>> /dev/sdb1              4232960     32840   4200120   1% /mnt/disk
>>> /root/tmpfs             131072         0    131072   0% /dev/shm
>>> /tmp/tmpfs              131072         0    131072   0% /dev/shm
>>> 
>>> ???? Strange devices.... both mounted under /dev/shm.
>>
>>I don't have any problems... mount version is 2.11g on 2.4.7
>>Uni-Processor and 2.4.7-pre3 SMP.
>>
>
>Mmm, mine is mount-2.11e on 2.4.7 final, SMP box.
>perhaps mount bug ?
>Going to get the new one...
>

Right, mount bug. Version 2.11h works fine...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7 #1 SMP Mon Jul 23 01:55:36 CEST 2001 i686
