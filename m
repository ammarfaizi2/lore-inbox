Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132379AbRCZIAB>; Mon, 26 Mar 2001 03:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132380AbRCZH7v>; Mon, 26 Mar 2001 02:59:51 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:55558 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S132379AbRCZH7c>;
	Mon, 26 Mar 2001 02:59:32 -0500
Date: Mon, 26 Mar 2001 09:58:27 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NCR53c8xx driver and multiple controllers...(not new prob)
Message-ID: <20010326095827.A9840@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.10.10103241647530.601-100000@linux.local> <3ABE71B9.9FAA232B@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABE71B9.9FAA232B@sgi.com>; from law@sgi.com on Sun, Mar 25, 2001 at 02:31:21PM -0800
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh <law@sgi.com> écrit :
> Here is the 'alternate' output when the ncr53c8xx driver is
> compiled in:
> 
> SCSI subsystem driver Revision: 1.00
> scsi-ncr53c7,8xx : at PCI bus 0, device 8, function 0
> scsi-ncr53c7,8xx : warning : revision of 35 is greater than 2.
> scsi-ncr53c7,8xx : NCR53c810 at memory 0xfa101000, io 0x2000, irq 58
[...]

Even if the ncr53c8xx is compiled in, these messages only appear
in 53c7,8xx.c. Did you give a try to:
<Y> SCSI support
<Y> SCSI disk support
<Y> NCR53C8XX SCSI support
with no other ncr/symbios driver ?

-- 
Ueimor
