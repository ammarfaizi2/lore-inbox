Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbUA2SHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 13:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbUA2SHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 13:07:41 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:37074 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266066AbUA2SHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 13:07:38 -0500
To: Eric <eric@cisu.net>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Can't enable DMA on my DVD in 2.6.1?
References: <873cae17pi.fsf@stark.xeocode.com>
	<200401282024.19658.eric@cisu.net>
In-Reply-To: <200401282024.19658.eric@cisu.net>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 29 Jan 2004 13:07:36 -0500
Message-ID: <8765eu1vdj.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric <eric@cisu.net> writes:

> 	If the first is the case, try compiling in one or more chipsets you suspect 
> are yours in Device Drivers->Char->(ALI Chipset support, ATI Chipset support 
> etc.) and Device Drivers->ATA/ATAPI->(ALI Chipset support, AMD Chipset 
> support) etc. etc. Find your chipsets and compile them into the kernel.

Ooh. The thing that had me confused was that the chipsets are under "PCI IDE
chipset support". But it seems it was always under that heading, even in 2.4.
So I'm not sure how I missed that. 

> 	However your problem is most certainly the first. It escapes me which device 
> section will solve your problem (CHAR or ATA/ATAPI) but try both, it won't 
> hurt to have some un-used code in the kernel. You can always remove un-needed 
> drivers when you pinpoint the driver you need.

I had all the IDE stuff disabled when I was trying to eliminate variables that
could cause the scsi ata_piix driver to fail. Then missed this subpanel when I
was turning stuff back on.


Thanks for the help.


-- 
greg

