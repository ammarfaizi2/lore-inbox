Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbULCEGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbULCEGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 23:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbULCEGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 23:06:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37544 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261920AbULCEF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 23:05:56 -0500
Message-ID: <41AFE612.4060608@pobox.com>
Date: Thu, 02 Dec 2004 23:05:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mru@inprovide.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dma errors with sata_sil and Seagate disk
References: <20041201115045.3ab20e03@homer.sarvega.com>	 <1101944482.30990.74.camel@localhost.localdomain>	 <yw1xpt1tuihe.fsf@ford.inprovide.com> <1102030431.7175.9.camel@localhost.localdomain>
In-Reply-To: <1102030431.7175.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2004-12-02 at 10:01, Måns Rullgård wrote:
> 
>>Is there some problem with Seagate drives in general?  I'm using two
>>ST3160827AS drives on an SI3114 controller, and haven't seen any
>>glitches yet.  That model is not in the blacklist, and performance is
>>what I'd usually expect.  Is it pure luck that has kept me away from
>>problems?
> 
> 
> I've never been able to get a non NDA list of the affected drives. Got
> to love vendors some days

I seriously doubt a complete list exists, NDA or no.  You'd have to poll 
each vendor.

I also suspect that a few of the more recent Seagate additions are 
simply masking a problem in the BIOS.

SiI 311x problems have a history of resolving themselves through BIOS 
updates and tweaks.  Most recently a lockup was solved by tweaking a 
'byte enable' setting in an nForce mobo BIOS.

	Jeff



