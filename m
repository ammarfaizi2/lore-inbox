Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUHFPPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUHFPPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHFPPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:15:45 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:22941 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S265784AbUHFPPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:15:32 -0400
Date: Fri, 6 Aug 2004 16:15:23 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Mark Lord <lkml@rtr.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
In-Reply-To: <41139CE0.1040106@rtr.ca>
Message-ID: <Pine.LNX.4.60.0408061613240.2622@fogarty.jakma.org>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
 <1091795565.16307.14.camel@localhost.localdomain> <41138C67.7040306@rtr.ca>
 <Pine.LNX.4.60.0408061453410.2622@fogarty.jakma.org> <41139CE0.1040106@rtr.ca>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Mark Lord wrote:

> The smartmontools can answer that question far more reliably
> than anyone here can.

IIRC, libata doesnt yet implement the raw IDE access (taskfile or 
somesuch?) needed to allow smartctl to work:

# smartctl -a /dev/sda
smartctl version 5.21 Copyright (C) 2002-3 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device:   Version:
Serial number: WD-WMAES2172674
Device type: disk
Local Time is: Fri Aug  6 16:14:29 2004 IST
Device does not support SMART

Device does not support Error Counter logging
Device does not support Self Test logging

:(

> Cheers

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
The control of the production of wealth is the control of human life itself.
 		-- Hilaire Belloc
