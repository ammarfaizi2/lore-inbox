Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUH3SEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUH3SEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268856AbUH3SCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:02:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17341 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268742AbUH3R6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:58:13 -0400
Message-ID: <41336AA8.1070401@pobox.com>
Date: Mon, 30 Aug 2004 13:58:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Warner <andyw@pobox.com>
CC: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [patch] libata: add ioctls to support SMART
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <413361BF.8020805@pobox.com> <20040830124225.A4358@florence.linkmargin.com>
In-Reply-To: <20040830124225.A4358@florence.linkmargin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>That implies, then, that you would add code to libata-scsi.c that 
>>translates the ATA-passthru SCSI command into an ATA command using the 
>>ata_scsi_translate() infrastructure.
> 
> 
> Speaking of which - I'm working on this and want to find like
> minded people playing in the libata-scsi.c/04-262r<n>.pdf
> sandbox, and collaborate with them.
> 
> If you're one of these people, ping me off list and we
> can pool our efforts.

I am trying convince someone to do it for me, since I'm working on new 
controller support ATM ;-)

It shouldn't be hard -- just a new function "ata_scsi_passthru_xlat" 
that translates the 04-262r<n>.pdf opcode into struct ata_taskfile. 
That's all that's needed for Step One.

John mentioned he might look at it...  but why don't you guys (and 
everyone else interested) just work publicly on linux-ide?  Share the 
knowledge and patches :)

	Jeff


