Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWCLRJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWCLRJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWCLRJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:09:33 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:28805 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751120AbWCLRJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:09:32 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Chris Boot <bootc@bootc.net>
Subject: Re: IDE CDROM - No DMA
Date: Sun, 12 Mar 2006 12:09:33 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200603101842.09251.kernel-stuff@comcast.net> <200603120128.44469.kernel-stuff@comcast.net> <441443F5.1060603@bootc.net>
In-Reply-To: <441443F5.1060603@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603121209.33218.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 10:53, Chris Boot wrote:
>
> You're using the generic ATA driver, not the one specific for your chipset,
> thus it's unlikely you'll get DMA on it at all. Judging by the fact you're
> using ata_piix for your SATA hard disk, try using the piix ATA driver for
> your on-board IDE. I assume you built your own kernel and forgot to enable
> this driver.
>
Some one pointed out offline -
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=163418 

Looks like it's a SATA combined mode problem as outlined in the above bug 
report. NONE of the options provided in the bug report worked for me though -
:(

Parag
