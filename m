Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTJUUlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbTJUUlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:41:55 -0400
Received: from [62.67.222.139] ([62.67.222.139]:28904 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S263361AbTJUUlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:41:53 -0400
Date: Tue, 21 Oct 2003 22:39:27 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Uncorrectable Error on IDE, significant accumulation
Message-ID: <20031021203927.GB4460%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: Ian Hastie <ianh@iahastie.clara.net>,
	linux-kernel@vger.kernel.org
References: <20031020132705.GA1171@synertronixx3> <20031020230510.GD15563%konsti@ludenkalle.de> <200310210203.45512.ianh@iahastie.local.net> <200310212024.00096.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310212024.00096.ianh@iahastie.local.net>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ian Hastie <ianh@iahastie.clara.net> [Tue, Oct 21, 2003 at 08:23:58PM +0100]:
> 
> : USB Function for DOS
> : Enable this item if you plan to use the USB ports on this mainboard in a DOS
> : environment.
> 
> Well assuming it implies some kind of 16bit related access mode then I suppose 
> it should be disabled anyway.  However I didn't see a specific "usb-keyboard 
> support for dos" in the manual.  What happens if you disable "USB Function 
> Support" completely?

I meant your quoted excerpt. I did not remember the correct spelling of
the option, remembered only something like "USB function for dos".

I thought also it must be some garbage left from BIOS or so, but when using
arrow keys to select another item, lilo puts something like
"2.6.0-test6-mm4mm4mm4mm4mm4mm4mm4mm4mm4mm4mm4mm4mm4mm4mm4mm4mm4"...
onto the screen. One backspace erases whole 5 lines.

I flashed BIOS cause I thought ECS might have fixed it (if it is its
fault) from January version to august version, same error.

I was fed up now and installed grub, which works like a charme.

Well, completely nokernel issue and I should write a bug report to the
lilo folks...

Or is it a BIOS error still which grub copes around with?

Regards, Konsti

-- 
2.6.0-test6-mm4
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 2:46, 4 users
