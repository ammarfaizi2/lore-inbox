Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWDRDVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWDRDVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 23:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWDRDVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 23:21:42 -0400
Received: from rtr.ca ([64.26.128.89]:46755 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751394AbWDRDVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 23:21:41 -0400
Message-ID: <44445B46.8040304@rtr.ca>
Date: Mon, 17 Apr 2006 23:21:42 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: James Ausmus <james.ausmus@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash devices
References: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
In-Reply-To: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Ausmus wrote:
>..
> +config IDE_COMPACT_FLASH_NO_UDMA
> +       bool "Disable UDMA for Compact Flash Devices"
> +       help
> +         This turns off the UDMA capability flag bit for any IDE device
> +         that identifies as Compact Flash - This is a workaround for
> +         cheap Compact Flash -> IDE adapters that don't support UDMA
> +         transfer speeds even if the CF card does.

I dunno.  This might be better done as a module/boot option
than as a rebuild-your-kernel configuration choice.

??
