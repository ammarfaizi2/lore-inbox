Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWCUTdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWCUTdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWCUTdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:33:52 -0500
Received: from customer-reverse-entry.64.151.106.180 ([64.151.106.180]:40658
	"EHLO charlie.albator.org") by vger.kernel.org with ESMTP
	id S932349AbWCUTdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:33:51 -0500
Message-ID: <44205513.8030109@poolshark.org>
Date: Tue, 21 Mar 2006 11:33:39 -0800
From: Denis Leroy <denis@poolshark.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, lkml@rtr.ca
Subject: Re: Some sata_mv error messages
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com> <441F8599.7080703@rtr.ca>
In-Reply-To: <441F8599.7080703@rtr.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>>
>> Without answering your specific question, just remember that sata_mv
>> is considerly "highly experimental" right now, and still needs some
>> workarounds for hardware errata.
>>
>> For now, the goal is a system that doesn't crash and doesn't corrupt
>> data.  If its occasionally slow or spits out a few errors, but
>> otherwise still works, that's pretty darned good :)
> 
> I'm currently working with the original authors of sata_mv, and have taken
> over maintenance of it for now.  It should progress from "highly
> experimental"
> to "production quality" over the next month or so.
> 
> The (mucho) updated driver I'm using here now is already much improved
> in many ways.  At some point, I'll break it out into patches for Jeff.
> 
> But there's one MAJOR bugfix patch that I'll release here shortly,
> to go with the interrupt handler fix already posted.

This is great news. Is there any relationship between the development of
this driver and the one maintained by Marvell that's available from
their web site ? Their latest version (3.6.1) is released under the GPL,
and is a very solid driver based our experience with it over the past
few years, though it's targeted at older versions of the linux kernel
and needs some porting to 2.6.16 (and contains redundant stuff like its
own scsi-ata layer).

Denis Leroy
