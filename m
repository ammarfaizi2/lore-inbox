Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTJ0Rh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTJ0Rh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:37:26 -0500
Received: from mail.broadpark.no ([217.13.4.2]:11406 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S263366AbTJ0RhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:37:25 -0500
Date: Mon, 27 Oct 2003 18:36:37 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
References: <3F9D402F.9050509@savages.net> <20031027165916.GE19711@gtf.org>
From: Arve Knudsen <aknuds-1@broadpark.no>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <oprxppvbgvq1sf88@mail.broadpark.no>
In-Reply-To: <20031027165916.GE19711@gtf.org>
User-Agent: Opera7.21/Linux M2 build 480
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003 11:59:17 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:

> On Mon, Oct 27, 2003 at 07:56:31AM -0800, Shaun Savage wrote:
>>
>>
>> >Are you using CONFIG_SCSI_SATA in 2.6?
>>
>> No, but I am trying now.
>> GREAT is works,
>> but the disk went from hda back to hde
>
> hmmm, with CONFIG_SCSI_SATA your SATA drives should show up as
>  /dev/sda not /dev/hde ...
>
> So, you're still using the drivers/ide driver, it appears.
>
> Regardless, it's most important to use what works for you ;-)
>
Excuse me, there's probably something I'm missing, but how do I use the 
SCSI_SATA driver for SiI 3112? I see the source file for it in the kernel 
tree (test9), but no option for it in menuconfig (I've enabled SATA under 
SCSI). Enabling the SiI SATA driver under ATA/ATAPI... compiles in the old 
driver am I right?

Thanks

Arve Knudsen
