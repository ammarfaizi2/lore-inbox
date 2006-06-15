Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031049AbWFOSfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031049AbWFOSfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031050AbWFOSfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:35:23 -0400
Received: from rtr.ca ([64.26.128.89]:7306 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1031049AbWFOSfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:35:22 -0400
Message-ID: <4491A867.1090904@rtr.ca>
Date: Thu, 15 Jun 2006 14:35:19 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
References: <1150385605.3490.85.camel@localhost.localdomain>	 <449191EE.2090309@drzeus.cx> <1150393058.3490.120.camel@localhost.localdomain>
In-Reply-To: <1150393058.3490.120.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-06-15 am 18:59 +0200, ysgrifennodd Pierre Ossman:
>> Alan Cox wrote:
>>> The data field is ulong, pointers fit in ulongs. Casting them to int is
>>> bad for 64bit systems.
>> It's in my (rather large) queue. I'm just waiting for a merge window. :)
> 
> I'd have thought that one was a "Duh whoops, fix it now" kind of
> submission for 2.6.17

Same here.  Simple & obvious bug fixes shouldn't need a "merge window".

Cheers
