Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRDAASM>; Sat, 31 Mar 2001 19:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131350AbRDAASC>; Sat, 31 Mar 2001 19:18:02 -0500
Received: from omecihuatl.rz.Uni-Osnabrueck.DE ([131.173.17.35]:7439 "EHLO
	omecihuatl.rz.uni-osnabrueck.de") by vger.kernel.org with ESMTP
	id <S131346AbRDAARq>; Sat, 31 Mar 2001 19:17:46 -0500
Date: Sun, 1 Apr 2001 02:12:48 +0200 (MET DST)
From: Arnd Bergmann <std7652@et.FH-Osnabrueck.DE>
To: linux-kernel@vger.kernel.org
cc: Francois Romieu <romieu@cogenit.fr>, Daniel Nofftz <daniel@nofftz.de>
Subject: Re: epic100 aka smc etherpower II
Message-ID: <Pine.GSO.4.21.0104010150370.4504-100000@gamma10>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Nofftz <daniel@nofftz.de> wrote:

> i can`t get my smc etherpower ii working with the 2.4.3 kernel.
> now i have downgraded to 2.4.2 and it works again ...
> does anyone have a suggestion, what the problem is ?

Looks to me like the problem I had in Febuary, see the thread
"epic100 in current -ac kernels" at 
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg28523.html
After I had upgraded my BIOS, the problems were gone and I stopped
looking into it. The DMA mapping code first introduced in 2.4.0-ac2
(smallest diff here) originally triggered the bug, which had different
symptoms depending on the configuration of the chipset.
Note that I have a VIA VT8363 (KT133) chipset while this is a VT82C595 
(VP2) chipset, so it is appearantly not limited to one very specific 
configuration.

Arnd <><


