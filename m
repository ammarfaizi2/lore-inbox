Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUDLRFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 13:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUDLRFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 13:05:14 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:58633 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S262960AbUDLRFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 13:05:07 -0400
Date: Mon, 12 Apr 2004 19:05:15 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Confused about 2.6 PnP support
Message-ID: <20040412170515.GA670@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I'm on the way of upgrading to 2.6.x kernel, and since I don't
have ISA cards (I don't even have an ISA bus in my mobo), I disabled
ISA support in my config (CONFIG_ISA), but I've noticed that PnP
support (CONFIG_PNP) depends on it :?

    AFAIK, PnP, strictly speaking, has nothing to do with the PCI
bus, but I think is common notation to talk about PnP referring
autoconfiguration of PCI cards, and I want to know if I need to
select PCI support for having my PCI cards correctly detected and
configured (currently my BIOS does the work), or if the PnP support
in kernel 2.6 is just for ISA cards. In addition to this, the PnP
BIOS support (which I think I may need so Linux correctly gets the
IO, IRQ and DMA settings for my parallel port) is marked as
EXPERIMENTAL (at least in 2.6.5)

    I want to know if I must tell my BIOS I don't have a PnP OS or
if, on the contrary, I should tell my BIOS that my OS is not PnP (I
only use Linux) and deselect PnP support (as well as ISA support) in
my 2.6.x kernel. Personally, I don't mind setting 'Non PnP OS' in my
BIOS and remove both CONFIG_ISA and CONFIG_PNP.

    BTW, ¿does Linux support rebalancing of PnP bus resources or I
better avoid conflicts...?

    Thanks a lot in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
