Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270796AbTGVL2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270797AbTGVL2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:28:40 -0400
Received: from ns.tasking.nl ([195.193.207.2]:11280 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S270796AbTGVL2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:28:40 -0400
Message-ID: <3F1D232B.2050200@netscape.net>
Date: Tue, 22 Jul 2003 13:42:35 +0200
From: David Zaffiro <davzaffiro@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021220 Debian/1.2.1-3
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: system_lists@nullzone.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with IDE - Ultra-ATA devices on a SiI chipset IDE controler
References: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
In-Reply-To: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I have a production server with a SiI680 pci device being used as a 
> IDE controller.
>    Connected to the external IDE controller I have 4 120GB IDE disks just 
> in raid5 Linux-software mode.
> 
> Well, I have detected some problems that i cannot understand (I am not a 
> expert so ... :-( ) ...
> ( I was using a HighPoint some time ago which gave me the same problems. 

Some time ago, I've had the same problem booting gentoo-1.4-rc2 with my Promise PDC20276, I had to append "acpi=off", otherwise the kernel-image of the cdrom suffered from the same problems... Maybe that'll help to get your production-server back online? 

However, I couldn't determine whether you are using ACPI, perhaps not. Personally, I wouldn't choose to use power-management (neither apm nor acpi) on a server in the first place, but that's just me...

