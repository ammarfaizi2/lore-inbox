Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271970AbRH2ODq>; Wed, 29 Aug 2001 10:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271972AbRH2ODg>; Wed, 29 Aug 2001 10:03:36 -0400
Received: from zeke.inet.com ([199.171.211.198]:22436 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S271970AbRH2ODW>;
	Wed, 29 Aug 2001 10:03:22 -0400
Message-ID: <3B8CF62F.69DA74C2@inet.com>
Date: Wed, 29 Aug 2001 09:03:27 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bruno Boettcher <bboett@erm1.u-strasbg.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [AMD] 79c970 ethernet card problems.....
In-Reply-To: <20010829152925.H1357@erm1.u-strasbg.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Boettcher wrote:
> 
> hello!
> my motherboard assigns it IRQ without any distinction, i have several
> cards on the same interrupt, e.g. the 2 ethernet cards are on irq 10 at
> the moment .... so maybe this is the real problem ... anyways i have:
> lspci:
> 00:0c.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
> LANCE] (rev 02)
>   Flags: stepping, medium devsel, IRQ 10
>   I/O ports at e000 [size=32]
> 
> /etc/modutils/network:
> options lance io=0xe000 irq=10
> alias eth1 lance  irq=10

You might try the pcnet32 module instead of the lance module.

HTH,

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
