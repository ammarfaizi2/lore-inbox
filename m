Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbTEORSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTEORSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:18:39 -0400
Received: from 12-250-182-80.client.attbi.com ([12.250.182.80]:19978 "EHLO
	sonny.eddelbuettel.com") by vger.kernel.org with ESMTP
	id S264122AbTEORSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:18:38 -0400
Date: Thu, 15 May 2003 12:31:28 -0500
From: Dirk Eddelbuettel <edd@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Tyan 2466 SMP lock with 2.4.21-rc1, HIGHMEM + heavy disk i/o
Message-ID: <20030515173128.GA10318@sonny.eddelbuettel.com>
References: <20030501135228.GA19643@sonny.eddelbuettel.com> <20030510134215.GA16397@sonny.eddelbuettel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510134215.GA16397@sonny.eddelbuettel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, May 10, 2003 at 08:42:15AM -0500, Dirk Eddelbuettel wrote:
> 
> System:
>   Tyan 2466 MPX board, 2 Athlon 1800MP, bios 1.01 from March 2002
>   1 gb ram, ibm + maxtor ide disks, ide cdrom + cdrw 
>   ati rage 128, sb pci 128, on-board 3c905 nic, ps/2 mouse
>   no other cards
>   hardware configuration unaltered since June of last year
> 
> Enabling or disabling the HIGHME patch is enough to trigger/suppress
> hard locking.  When HIGHMEM is enabled, locking occurs very easily when
> trying to copy a (cloop-mounted) Knoppix image, or even when compiling
> a kernel.

As a follow-up, 2.4.21-rc2 looks fine so far. The only other change was to
enable support the proper mobo i/o chipset, which I should have done earlier.

Dirk

> I run fairly stock kernels (from Debian kernel source packages) with the 
> win4lin patch as the only external patch.  ACPI is disabled. Disk access is
> not tuned in any way, DMA gets enabled by default. 
> 
> Dirk
> 
> -- 
> Don't drink and derive. Alcohol and algebra don't mix.

-- 
Don't drink and derive. Alcohol and algebra don't mix.
