Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWC2Ocv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWC2Ocv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWC2Ocv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:32:51 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:17244 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750757AbWC2Ocu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:32:50 -0500
Date: Wed, 29 Mar 2006 08:30:52 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Schedule for adding pata to kernel?
In-reply-to: <5UTfA-5uK-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: James Cloos <cloos@jhcloos.com>
Message-id: <442A9A1C.1020004@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5SuEq-6ut-39@gated-at.bofh.it> <5TDme-22E-27@gated-at.bofh.it>
 <5UAcC-3bd-3@gated-at.bofh.it> <5UH4o-4RJ-27@gated-at.bofh.it>
 <5UTfA-5uK-17@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cloos wrote:
> Incidently, on that front, what is the magic to make it work?
> 
> I've not yet tried with 2.6.16 final, but I didn't have any luck with
> earlier versions.
> 
> I have a:
> 
> ,----[lspci]
> | 00:1f.1 0101: 8086:244a (rev 03)
> | 00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03)
> `----
> 
> but never managed to determine the CONFIG that used ata_piix rather
> than the old ide drivers.  Each attempt left me with a kernel which
> could not mount its root....

What distribution? If you're building ata_piix and the other drivers 
(scsi, sd, etc.) as modules you'll have to play with your initrd to get 
it to load the correct modules on startup. If you build them into the 
kernel, it should just work..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

