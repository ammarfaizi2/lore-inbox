Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132396AbRDANZg>; Sun, 1 Apr 2001 09:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRDANZ1>; Sun, 1 Apr 2001 09:25:27 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:30212 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S132396AbRDANZX>;
	Sun, 1 Apr 2001 09:25:23 -0400
Date: Sun, 1 Apr 2001 15:23:26 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: epic100 aka smc etherpower II
Message-ID: <20010401152326.A8919@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.21.0103312129170.6125-100000@infcip10.uni-trier.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103312129170.6125-100000@infcip10.uni-trier.de>; from nofftz@castor.uni-trier.de on Sat, Mar 31, 2001 at 09:40:10PM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Nofftz <nofftz@castor.uni-trier.de> écrit :
[...]
> i can`t get my smc etherpower ii working with the 2.4.3 kernel.
> now i have downgraded to 2.4.2 and it works again ...
> does anyone have a suggestion, what the problem is ?
[...]
> Mar 31 19:23:29 hyperion kernel: eth0: Setting half-duplex based on MII
> xcvr 3 register read of 0001.
> Mar 31 19:23:29 hyperion kernel: Real Time Clock Driver v1.10d
> Mar 31 19:23:29 hyperion kernel: eth0: Setting full-duplex based on MII #3
> link partner capability of 45e1.
> Mar 31 19:24:31 hyperion kernel: NETDEV WATCHDOG: eth0: transmit timed out

How does it behave if you give it the following args:
options=4
full_duplex=4

> lspci output:
[...]

No USB controller ?

-- 
Ueimor
