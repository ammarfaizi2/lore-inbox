Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVBFQLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVBFQLv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 11:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVBFQLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 11:11:50 -0500
Received: from main.gmane.org ([80.91.229.2]:12488 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261180AbVBFQLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 11:11:18 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data corruption
Date: Sun, 6 Feb 2005 16:59:01 +0100
Message-ID: <MPG.1c7037c9d0a0407989711@news.gmane.org>
References: <1107519382.1703.7.camel@localhost.localdomain> <200502041241.28029.david-b@pacbell.net> <16900.5586.511772.651559@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-219-149.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
Cc: linux-usb-devel@lists.sourceforge.net
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:
> 
> I haven't tried lately, but my USB/FireWire enclosure never worked
> with Linux (or WinNT under firewire, sigh...) so I haven't touched it
> in months.  Money down the drain.

I have a MAGNEX/ViPower USB/FirWire external HD enclosure. I 
found that it works pretty fine (albeit slowly) when connected 
to the USB 1.1 ports built in my Dell Inspiron 8200, but trying 
to connect it via the Hamlet PCMCIA USB2 Card Adapter doesn't 
work (it seems it gets assigned minors 1,2,3,4,5,6,... and so 
on forever until I unplug it).

OTOH, I'm not sure if it's a PCMCIA adapter problem or USB2 
enclosure problem. Indeed, if I don't load the EHCI modules, 
and thus limit myself to the USB1.1 capabilities of the PCMCIA 
adapters, I get other errors (I'll have to write a cleaner bug 
report on this. And try the PCMCIA card with some other USB 
device. Wish I could use my softmodem under Linux :(). (Using 
kernel 2.6.10-3 from Debian.)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

