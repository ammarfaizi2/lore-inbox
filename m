Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTACSEb>; Fri, 3 Jan 2003 13:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTACSEb>; Fri, 3 Jan 2003 13:04:31 -0500
Received: from 177-2.SPEEDe.golden.net ([216.75.177.2]:56585 "EHLO
	thebeever.com") by vger.kernel.org with ESMTP id <S267612AbTACSEa>;
	Fri, 3 Jan 2003 13:04:30 -0500
Date: Fri, 3 Jan 2003 13:13:38 -0500
From: Richard Baverstock <beaver@gto.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGPGART for VIA vt8235, kernel 2.4.21-pre2
Message-Id: <20030103131338.4c9102e3.beaver@gto.net>
In-Reply-To: <20030103174323.GA10327@codemonkey.org.uk>
References: <20030102145346.27a21ed9.beaver@gto.net>
	<20030103171617.B4502@ucw.cz>
	<20030103122216.39cedd3f.beaver@gto.net>
	<20030103174323.GA10327@codemonkey.org.uk>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003 17:43:23 +0000
Dave Jones <davej@codemonkey.org.uk> wrote:


> What exactly do you mean by 'it' ? The PCI device id ?
> 

Since he was referring to the host bridge names, i thought he meant the naming conventions.

> If they share the same device ID, then Bernhards patch is
> really no better...
> 
> #define PCI_DEVICE_ID_VIA_P4X333       0x3168
> 
> In fact, P4X333 defines a chipset rather than a chip.
> According to ..
> http://www.viatech.com/en/apollo/p4x333.jsp and
> http://www.viatech.com/en/apollo/p4x400.jsp ,
> the northbridge is a VT8754 in both models, so the
> correct define would seem to be PCI_DEVICE_ID_VIA_8754

Then we were both wrong, and it should be vt8754.

> Just to confirm, device 3168 is the host bridge in lspci output right?
> And this does all work when you run a DRI application ?
> 

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3168 (rev 03)

And yes, DRI works :)

Rich

