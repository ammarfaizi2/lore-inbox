Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161491AbWJLFzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161491AbWJLFzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161544AbWJLFzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:55:07 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:26768 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161491AbWJLFzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:55:01 -0400
Message-ID: <452DD8B2.9040007@drzeus.cx>
Date: Thu, 12 Oct 2006 07:54:58 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH] drivers/{mmc,misc}: handle PCI errors on resume
References: <20061012020645.50871.qmail@web36715.mail.mud.yahoo.com>
In-Reply-To: <20061012020645.50871.qmail@web36715.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't Jeff love me anymore? :(

Alex Dubov wrote:
> --- Jeff Garzik <jeff@garzik.org> wrote:
>
>   
>> Date: Wed, 11 Oct 2006 17:48:09 -0400
>> From: Jeff Garzik <jeff@garzik.org>
>> To: oakad@yahoo.com, Andrew Morton <akpm@osdl.org>,
>> 	LKML <linux-kernel@vger.kernel.org>
>> Subject: [PATCH] drivers/{mmc,misc}: handle PCI errors on resume
>>
>>
>> Since pci_enable_device() is one of the first things called in the
>> resume step, take the minimalist approach and return immediately, if
>> pci_enable_device() fails during resume.
>>
>> Also, in sdhci:  don't check for impossible condition (chip==NULL)
>>
>> Signed-off-by: Jeff Garzik <jeff@garzik.org>
>>
>>     

I'm just being cautious. "This can't happen" is usually the last thing
you here before the end. ;)

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
  OLPC, developer                     http://www.laptop.org

