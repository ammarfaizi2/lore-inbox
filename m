Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030852AbWFORHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030852AbWFORHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030858AbWFORHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 13:07:49 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:23438 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030852AbWFORHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 13:07:48 -0400
Message-ID: <449193E2.4030902@drzeus.cx>
Date: Thu, 15 Jun 2006 19:07:46 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
References: <1150385605.3490.85.camel@localhost.localdomain>	<449191EE.2090309@drzeus.cx> <20060615170403.GB8694@flint.arm.linux.org.uk>
In-Reply-To: <20060615170403.GB8694@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Jun 15, 2006 at 06:59:26PM +0200, Pierre Ossman wrote:
>   
>> Alan Cox wrote:
>>     
>>> The data field is ulong, pointers fit in ulongs. Casting them to int is
>>> bad for 64bit systems.
>>>       
>> It's in my (rather large) queue. I'm just waiting for a merge window. :)
>>     
>
> I didn't see the original message, but I suspect this is about the
> following, which you can see is already queued up for Linus.
>
>   

Yup. Now who's the scoundrel that forgot to cc me on that patch? :)

Rgds
Pierre

