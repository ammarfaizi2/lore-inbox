Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUGEXmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUGEXmQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 19:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUGEXmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 19:42:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46261 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262114AbUGEXmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 19:42:08 -0400
Message-ID: <40E9E73B.5080002@pobox.com>
Date: Mon, 05 Jul 2004 19:41:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <TK-SHOCKWAVE@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disabled SATA (ICH5R) support cause hard seeks to disks and APIC
 errors on i875P chipset
References: <971519831@web.de>
In-Reply-To: <971519831@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> So a nother question accodring APIC and SATA on a Pentium 4 HT enabled and Intel 875P Chipset
> 
> Maybe Jeff Garzik or Andrew can answer it..
> 
> Since 2.6.4-mm* I get wired problemes when I disable the SATA Drive for the Intel ICH5R Controller on a Abit-IC7 Mainboard. I want to use the normal Intel IDE driver. But when I diasbled it in kernel + recompile and reboot the machine my harddrives make hard seeks and fancy noises also I get APIC error on CPU0 without any hints or oops and few minutes later after using the machine it freezes the harddisk (maybe power off,I noticed it on reset that the disks power on with SATA support it does not appear). If the SATA driver under SCSI is turned on no problems.

How are you disabling the SATA drive?  BIOS?  Kernel configuration?

	Jeff



