Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282675AbRK0Aco>; Mon, 26 Nov 2001 19:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282444AbRK0Acf>; Mon, 26 Nov 2001 19:32:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17674 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282675AbRK0AcY>; Mon, 26 Nov 2001 19:32:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Journaling pointless with today's hard disks?
Date: 26 Nov 2001 16:32:05 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tumu5$e36$1@cesium.transmeta.com>
In-Reply-To: <0111261159080F.02001@localhost.localdomain> <Pine.LNX.3.95.1011126151922.29433A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1011126151922.29433A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> It isn't that easy!  Any kind of power storage within the drive would
> have to be isolated with diodes so that it doesn't try to run your
> motherboard as well as the drive. This means that +5 volt logic supply 
> would now be 5.0 - 0.6 =  4.4 volts at the drive, well below the design
> voltage. Use of a Schottky diode (0.34 volts) would help somewhat, but you
> have now narrowed the normal power design-margin by 90 percent, not good.
> 

Hardly a big deal since most logic is 3.3V these days (remember, you
don't need to maintain VccIO since the bus is dead anyway).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
