Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTBERdx>; Wed, 5 Feb 2003 12:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTBERdx>; Wed, 5 Feb 2003 12:33:53 -0500
Received: from kim.it.uu.se ([130.238.12.178]:54656 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261855AbTBERdw>;
	Wed, 5 Feb 2003 12:33:52 -0500
Date: Wed, 5 Feb 2003 18:43:13 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302051743.SAA11495@kim.it.uu.se>
To: b_adlakha@softhome.net, davej@codemonkey.org.uk
Subject: Re: HYPERTHREADING on older P4???
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003 13:07:07 +0000, Dave Jones wrote:
>There are countless rumours of being able to enable extra siblings
>by poking MSRs, but not one person has to my knowledge achieved this.
>Some folks have also allegedly found that snipping pins or wiring extra
>bits to them have enabled the 'extra sibling'. Whether this is true or
>not, and whether it is 100% equivalent to a real HT part is again,
>questionable.

HT-capable P4s decide at RESET (or INIT?) time whether to enable
the second thread or not by sampling one of the data or address pins.
The chipset is supposed to drive that pin low or high according to
how HT has been set up in the BIOS. This is mentioned in the
3.06 GHz P4 data sheet.

/Mikael
