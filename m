Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWCUEs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWCUEs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 23:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWCUEs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 23:48:27 -0500
Received: from rtr.ca ([64.26.128.89]:58083 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030294AbWCUEs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 23:48:26 -0500
Message-ID: <441F8599.7080703@rtr.ca>
Date: Mon, 20 Mar 2006 23:48:25 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: sander@humilis.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca
Subject: Re: Some sata_mv error messages
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com>
In-Reply-To: <441F508E.1030008@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>
> Without answering your specific question, just remember that sata_mv is 
> considerly "highly experimental" right now, and still needs some 
> workarounds for hardware errata.
> 
> For now, the goal is a system that doesn't crash and doesn't corrupt 
> data.  If its occasionally slow or spits out a few errors, but otherwise 
> still works, that's pretty darned good :)

I'm currently working with the original authors of sata_mv, and have taken
over maintenance of it for now.  It should progress from "highly experimental"
to "production quality" over the next month or so.

The (mucho) updated driver I'm using here now is already much improved
in many ways.  At some point, I'll break it out into patches for Jeff.

But there's one MAJOR bugfix patch that I'll release here shortly,
to go with the interrupt handler fix already posted.

Cheers

Mark
