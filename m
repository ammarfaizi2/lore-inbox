Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268205AbUHFQzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268205AbUHFQzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUHFQvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:51:18 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:22671 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S268182AbUHFQsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:48:10 -0400
Date: Fri, 6 Aug 2004 17:47:38 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
In-Reply-To: <4113A684.8050302@pobox.com>
Message-ID: <Pine.LNX.4.60.0408061742300.2622@fogarty.jakma.org>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
 <1091795565.16307.14.camel@localhost.localdomain> <4113A684.8050302@pobox.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Jeff Garzik wrote:

> libata does not (yet) retry cable errors, for example.  Paul, don't 
> automatically assume the disk is bad, try swapping cables.

Hmmm, I'll see if that's possible, though:

- My spare cables are exact same brand
- I dont know how to 'cycle' the drive

(iirc, libata doesnt yet support hotplug and/or the old "reset the 
bus by doing echo 'scsi remove-single-device' and then 
'add-single-device" trick)

ie, is possible to avoid a reboot?

also, the drive has been running fine since late may with this cable, 
and two other identical cables/drives are still happily running. 
Also, before putting the drives into use, I did some load-testing 
(bonnie++) which they survived quite happily.

> 	Jeff

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Bore, n.:
 	A person who talks when you wish him to listen.
 		-- Ambrose Bierce, "The Devil's Dictionary"
