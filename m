Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030845AbWKOSmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030845AbWKOSmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030842AbWKOSmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:42:10 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:10384 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030836AbWKOSmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:42:08 -0500
Message-ID: <455B5F78.5060401@garzik.org>
Date: Wed, 15 Nov 2006 13:42:00 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>	<20061114.190036.30187059.davem@davemloft.net>	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>	<20061114.192117.112621278.davem@davemloft.net>	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>	<455A938A.4060002@garzik.org> <m3fyckdeam.fsf@defiant.localdomain>
In-Reply-To: <m3fyckdeam.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> So far, MSI history on x86 has always followed these rules:
>> * it works on Intel
>> * it doesn't work [well | at all] on AMD/NV
> 
> I don't know how does it look when it doesn't work etc. but certainly
> both NV Ethernet and HDA seem to work for me and:

Oh I certainly agree (and it appears that Roland agrees) that MSI works 
/somewhere/ on NV.  I give kudos to NV to working on forcedeth to make 
sure it works well with MSI.  But unfortunately NV was also in the bug 
report(s) linked.

Though OTOH, the driver wasn't calling pci_intx() nor setting irq flags 
correctly, so who knows.

	Jeff



