Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTJUTYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbTJUTYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:24:31 -0400
Received: from mra01.ex.eclipse.net.uk ([212.104.129.110]:44510 "EHLO
	mra01.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S263244AbTJUTYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:24:02 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Uncorrectable Error on IDE, significant accumulation
Date: Tue, 21 Oct 2003 20:23:58 +0100
User-Agent: KMail/1.5.4
References: <20031020132705.GA1171@synertronixx3> <20031020230510.GD15563%konsti@ludenkalle.de> <200310210203.45512.ianh@iahastie.local.net>
In-Reply-To: <200310210203.45512.ianh@iahastie.local.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310212024.00096.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 Oct 2003 02:03, Ian Hastie wrote:
> On Tuesday 21 Oct 2003 00:05, Konstantin Kletschke wrote:
> > The new K7S5A Pro behaves strange.
> >
> > When lilo comes up, it gets keyboard input containing of 4-6 lines
> > "t:t:t:t:t:t:t:t:t:t:t:t:"...
> > When hitting backspace whole line gets cleared, enter boots default then.
> > WTF?
> > even with no keyboard plugged in. My first thought was disabling
> > "usb-keyboard support for dos" but... only a usb printer, ethernet and
> > serial modem are plugged in...
>
> Kernel configuration optins aren't going to affect LILO

Oh well. *8}  It's that funny thing called the BIOS isn't it.  Doh!!

: USB Function for DOS
: Enable this item if you plan to use the USB ports on this mainboard in a DOS
: environment.

Well assuming it implies some kind of 16bit related access mode then I suppose 
it should be disabled anyway.  However I didn't see a specific "usb-keyboard 
support for dos" in the manual.  What happens if you disable "USB Function 
Support" completely?

-- 
Ian.


