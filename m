Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422814AbWI2UaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbWI2UaH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422816AbWI2UaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:30:07 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:19710 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1422814AbWI2UaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:30:05 -0400
Message-ID: <451D8246.7060703@freescale.com>
Date: Fri, 29 Sep 2006 15:29:58 -0500
From: Timur Tabi <timur@freescale.com>
Organization: Freescale
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: SATA: "unknown partition table" error, fdisk can't fix, works
 in 2.6.13
References: <451D7DE8.8020504@freescale.com> <BA55C0C9-B58F-473E-9412-B582411D017A@bootc.net>
In-Reply-To: <BA55C0C9-B58F-473E-9412-B582411D017A@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Timur,
> 
> fdisk manipulates DOS-style partition maps. Have you compiled these into 
> your latest kernel? You don't actually have any errors in the below 
> messages, other than the partition map being unreadable...

Yes, that was it!  Thank you very much.  All I had to do was select "PC BIOS (MSDOS partition tables) support" configuration option, and that was it.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
