Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263524AbTJWLE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 07:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbTJWLEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 07:04:00 -0400
Received: from data.iemw.tuwien.ac.at ([128.131.70.3]:24965 "EHLO
	data.iemw.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263524AbTJWLD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 07:03:59 -0400
Message-ID: <3F97B5A4.1090203@tuwien.ac.at>
Date: Thu, 23 Oct 2003 13:04:04 +0200
From: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
Organization: IEMW TU-Wien
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, de-at, cs
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: nforce2 random lockups - still no solution ?
References: <3F95748E.8020202@tuwien.ac.at>	<200310211113.00326.lkml@lpbproductions.com>	<20031022085449.GA21393@swszl.szkp.uni-miskolc.hu>	<3F96847C.4000506@tuwien.ac.at>	<20031022133327.GA25283@swszl.szkp.uni-miskolc.hu>	<3F97AACB.2020609@tuwien.ac.at> <16279.45595.995992.419848@alkaid.it.uu.se>
In-Reply-To: <16279.45595.995992.419848@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > What I'd like to know is whether this bug is AMD processor or chipset 
> > related.
>
>Chipset and/or BIOS. AMD processors are known to work in other mobos.
>
>You may try disabling just I/O-APIC or ACPI.
>  
>
No, only disabling local apic really helps. On both ASUS and MSI nforce2 
motherboards. I can even enable apic and acpi with disabled local apic 
(anyway with XT-PIC only) and have no troubles. The lockups seem to 
appear when drivers heavily employing DMA are used (as udma5 hdd or 
framegrabber).

