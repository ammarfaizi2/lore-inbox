Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271742AbTHNSiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275341AbTHNSiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:38:19 -0400
Received: from chromatix.demon.co.uk ([80.177.102.173]:16570 "EHLO
	lithium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id S271742AbTHNSiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:38:18 -0400
Date: Thu, 14 Aug 2003 19:38:15 +0100
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: agpgart failure on KT400
From: Jonathan Morton <chromi@chromatix.demon.co.uk>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <779ACC8A-CE86-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded to a m/board using the KT400 chipset - specifically 
an Abit KD7-G - and now find that I can't load agpgart.  The relevant 
kernel messages:

agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: unable to determine aperture size.

This results in my inability to load XFree86, using the proprietary ATI 
drivers, which appear to require AGP support.  Note that the same 
problem appears using ATI's "internal agpgart module", just to show I 
know the difference.  The regular XFree86 drivers probably work without 
AGP - I haven't bothered trying yet.

NB: I tried sending this to Jeff Hartmann, but his address at 
precisioninsight.com is dead.  Please CC me, I'm not subscribed to the 
list.  Better still, refer me to someone who actually knows what to do 
about it.

The BIOS is set up for either a 256MB or 64MB AGP aperture - whichever 
of the two settings makes no difference.  The video card is a Radeon 
9700 Pro, 128MB.  The kernel configuration includes ACPI and 
HIGHMEM-4GB support, if that is at all relevant.

This problem is identically present in 2.4.21 and 2.4.22-rc2.

I can provide extra information as needed, just ask.  I have a feeling 
someone's going to ask me for lspci output, but I'll leave that until 
someone who knows what they're doing asks me.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@chromatix.demon.co.uk
website:  http://www.chromatix.uklinux.net/
tagline:  The key to knowledge is not to rely on people to teach you it.

