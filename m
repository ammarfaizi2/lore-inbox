Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbRGLVzq>; Thu, 12 Jul 2001 17:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbRGLVzh>; Thu, 12 Jul 2001 17:55:37 -0400
Received: from jalon.able.es ([212.97.163.2]:64427 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S266797AbRGLVyo>;
	Thu, 12 Jul 2001 17:54:44 -0400
Date: Thu, 12 Jul 2001 23:56:32 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Daniel Harvey <daniel@amristar.com.au>
Cc: Daniel Harvey <daniel@amristar.com.au>, Chris Wedgwood <cw@f00f.org>,
        hahn@coffee.psychology.mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
Message-ID: <20010712235632.A24828@werewolf.able.es>
In-Reply-To: <NEBBJDBLILDEDGICHAGAKEAFCGAA.daniel@amristar.com.au> <NEBBJDBLILDEDGICHAGACEAGCGAA.daniel@amristar.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <NEBBJDBLILDEDGICHAGACEAGCGAA.daniel@amristar.com.au>; from daniel@amristar.com.au on Thu, Jul 12, 2001 at 06:48:57 +0200
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010712 Daniel Harvey wrote:
>Got an idea - the video card in the Compaq uses a piece of shared memory
>(between 2-8M).
>
>Would Linux be able to detect that?
>

The bios just tells linux it has less ram. I have a laptop with all SiS chips,
vga is a SiS630, and uses 8Mb added to its own 8Mb. Linux just thinks it has
120Mb of ram.

>> mem=250M - slow
>> mem=252M - slow
>> mem=256M - hangs on boot,

Do not know why it is slow, but it hangs because it is trying to use reserved video
mem.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.6-ac2 #1 SMP Sun Jul 8 23:57:11 CEST 2001 i686
