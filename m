Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292260AbSBBKOe>; Sat, 2 Feb 2002 05:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292262AbSBBKOY>; Sat, 2 Feb 2002 05:14:24 -0500
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:8969 "EHLO
	manty.net") by vger.kernel.org with ESMTP id <S292260AbSBBKOI>;
	Sat, 2 Feb 2002 05:14:08 -0500
Date: Sat, 2 Feb 2002 11:14:03 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Cc: acpi@phobos.fachschaften.tu-muenchen.de
Subject: Wake On Lan broken since kernel version 2.4.14
Message-ID: <20020202101403.GA6122@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On kernel 2.4.13 with acpi compiled one could have at least the cards which
use the driver 3c59x, when option enable_wol=1 was set, to wake his computer
when a WOL packet had been sent to the net.

However, since version 2.4.14 and up to 2.4.18pre7 inclusive, WOL is not
working, and it is again because of ACPI code, if you don't compile ACPI in
and you compile for example APM, then it will work, but if you compile ACPI
then it won't.

I'd like to provide more info on this, but I don't know what else to say
exept that this was tested on a PIII via chipset based machine and on a PIV
intel based one with the same results, I'm using Donald Becker's ether-wake.

If you want more info I'll try to gatter it.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
