Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWCQOoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWCQOoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWCQOoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:44:16 -0500
Received: from main.gmane.org ([80.91.229.2]:43494 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750810AbWCQOoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:44:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Fri, 17 Mar 2006 16:43:55 +0200
Message-ID: <dvehv7$j9r$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.49.33
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:

> Just for the records, it happens actually quite often that some little
> features / improvements of a chipset have bugs; from time to time,
> you'll see a BIOS update that doesn't really do more than switching
> off that feature. I guess that quite some of our quirks originate from
> looking at what a newer BIOS configures differently compared to an
> older version.  Some instability can be fixed that way (though it's
> better to have a fix for such a bug inside the BIOS: this way, the fix
> is in place at the time the Linux kernel is loaded, so there's no way
> for it to eg. cause memory corruption between loading the kernel and
> issueing the quirks.)
I know, but in this case I got this answer: 
" Dear Friend :
  Thank you for contacting ASUS Customer Service.
  My name is ZYC, and I would be assisting you today. 
 sorry ,due to chipset limitation ,
when you add a PCI AUDIO card to a board which use VIA VT8237 southbridge
controller ,
the built in AC97 audio will be disabled automaticly .
it is a chip limitation without way to fix ."

Meantime I tried the patch against the 2.6.13-15 kernel shipped with SuSE 10
(applied without errors), and altough I see 
PCI: enabled onboard AC97/MC97 devices

in the logs, the onboard  card doesn't appear in lspci.

I'm downloading the 2.6.16-rc6 kernel to try with that one. Mine is an
A8V-Deluxe, so I don't know why it didn't work. :-( I have the latest Asus
bios and verified that it is enabled in the BIOS (I know, it doesn't really
matter, but I mention here).

Andras

-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


