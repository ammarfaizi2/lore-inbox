Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbTBDBQX>; Mon, 3 Feb 2003 20:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTBDBQX>; Mon, 3 Feb 2003 20:16:23 -0500
Received: from fmr04.intel.com ([143.183.121.6]:50424 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267084AbTBDBQW>; Mon, 3 Feb 2003 20:16:22 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: ducrot@poupinou.org
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: RE: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Mon, 3 Feb 2003 17:25:38 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ducrot Bruno [mailto:poup@poupinou.org] 
> This patch is for s4bios support in 2.5.59 with acpi-20030123.
> 
> This is the 'minimal' requirement.  Some devices (especially the
> IDE part) are not well resumed.  Handle with care..
> 
> Note also that the resuming part (I mean IDE) was more stable
> with an equivalent patch when I tested with 2.5.54 (grumble 
> grumble)...
> 
> I think also that it is a 'good' checker for devices power management
> in general...

I'd really rather just have S4OS (aka swsusp) in 2.5 patches -- if the
OS can do S4 on its own, that is really preferable to S4bios.

Regards -- Andy
