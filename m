Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270051AbRHGDpL>; Mon, 6 Aug 2001 23:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270052AbRHGDpC>; Mon, 6 Aug 2001 23:45:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18816
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270051AbRHGDox>; Mon, 6 Aug 2001 23:44:53 -0400
Date: Mon, 6 Aug 2001 20:44:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Colonel <klink@clouddancer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip driver problem
Message-ID: <20010806204450.A584@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010807023200.0E3D2784C1@mail.clouddancer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010807023200.0E3D2784C1@mail.clouddancer.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 07:32:00PM -0700, Colonel wrote:
> In clouddancer.list.kernel, Tom Rini wrote:
> >
> >On Mon, Aug 06, 2001 at 12:19:10PM -0400, Albert D. Cahalan wrote:
> >
> >> This is the Force PowerCore 6750 single-board computer with
> >> a PowerPC processor and the DEC 21143 Ethernet chip.
> >
> >Just wondering, but when booting 2.4.x, do you see something like:
> >"Unknown bridge resource %d: assuming transparent"
> >for the tulip?
> 
> Linux ns1.clouddancer.com 2.4.8-pre4 #3 SMP Sat Aug 4 12:32:55 PDT 2001 i686 unknown
> ...
> Unknown bridge resource 0: assuming transparent
> Unknown bridge resource 1: assuming transparent
> Unknown bridge resource 2: assuming transparent
> ...
> Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
> tulip0:  EEPROM default media type Autosense.
> tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
> tulip0:  MII transceiver #0 config 1000 status 782d advertising 01e1.
> eth0: Digital DS21140 Tulip rev 34 at 0xb400, 00:80:C8:45:97:AF, IRQ 12.
> 
> It's been working fine here, 3 cards over 2 computers.

Yes, but what arch and do either of the above corrispond to the tulip?
I asked because sometimes when the code prints msgs like the above, it's
doing the wrong thing and ends up wreaking havoc.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
