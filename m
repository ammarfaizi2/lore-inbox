Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSJ2JVV>; Tue, 29 Oct 2002 04:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSJ2JVV>; Tue, 29 Oct 2002 04:21:21 -0500
Received: from hermes.univ-evry.fr ([194.199.90.32]:38829 "EHLO
	hermes.univ-evry.fr") by vger.kernel.org with ESMTP
	id <S261732AbSJ2JVU>; Tue, 29 Oct 2002 04:21:20 -0500
Date: Tue, 29 Oct 2002 10:20:44 +0100 (CET)
From: Daniel Goujot <Daniel.Goujot@maths.univ-evry.fr>
To: Nuno Monteiro <nuno@itsari.org>,
       Stephen Wille Padnos <stephen.willepadnos@verizon.net>
cc: <linux-kernel@vger.kernel.org>
Subject: rtl8139 : is a development driver (was: Re: No rtl8139 found in
 menuconfig in linux-2.2.22)
In-Reply-To: <20021028162819.GA9723@hobbes.itsari.int>
Message-ID: <Pine.LNX.4.33L2.0210291002420.18891-100000@grozny.maths.univ-evry.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Nuno Monteiro wrote:

> On 28.10.02 16:00 Daniel Goujot wrote:
>
> > make menuconfig
> > -- don't find the rtl8139 (I found the tulip network driver, not the
> > rtl8139 network driver)
>
>
> You need to say 'Y' in ->
>    -- Code maturity level options
>     -- Prompt for development and/or incomplete code/drivers
>
> Then you'll have
>     -- Network device support
>      -- Ethernet (10 or 100Mbit)
>       -- RealTek 8129/8139 (not 8019/8029!) support (NEW)

Thank you. Shame on me, this solution shows up with
google.fr/search?q=CONFIG_RTL8139 ... (though, can you add in the
linux-2.2.22/Documentation/Configure.help file that CONFIG_RTL8139 is an
experimental driver ? Alternatively, does it exist a file containing this
type of datas (e.g., for CONFIG_RTL8139 : Code maturity level options ->
Prompt for development + Network device support -> Ethernet (10 or
100Mbit) -> RealTek 8129/8139).

Thank you for both your helps !

[end of story: Yesterday, I have compiled tht rtl8139 driver by hacking
the Makefiles, and I didn't try make xconfig of make config]

	Daniel Goujot

