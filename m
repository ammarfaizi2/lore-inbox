Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWDSPwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWDSPwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDSPwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:52:39 -0400
Received: from outgoing2.smtp.agnat.pl ([193.239.44.84]:28433 "EHLO
	outgoing2.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1750940AbWDSPwi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:52:38 -0400
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Subject: Re: sata suspend resume ...
Date: Wed, 19 Apr 2006 17:52:18 +0200
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200604191752.18797.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 17:26, Jeff Chua wrote:
> Any change of getting suspend/resume to work on my IBM X60s notebook.
>
> Disk model is ...
>
>  	MODEL="ATA HTS541060G9SA00"
>  	FW_REV="MB3I"
>
> Linux 2.6.17-rc2.
>
> System suspends ok. Resume ok. but no disk access after that.

It contains AHCI, right? Then try 
http://www.spinnaker.de/linux/c1320/sata-resume-2.6.16.5.patch

For some others like ata_piix ,,SATA ACPI objects support'' patch by Randy 
Dunlap is needed AFAIK. See http://www.xenotime.net/linux/SATA for old 
versions of these. It seems that nothing happened in this area in last 2 
months. It no longer applies (parts of it are already in mailine, other parts 
changed too much). Z60* ThinkPads probably need that patch.

> Thanks,
> Jeff

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
