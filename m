Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbUKRRiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbUKRRiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbUKRR3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:29:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:21225 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262800AbUKRR1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:27:05 -0500
Subject: Re: Missing SCSI command in the allowed list?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <419CEC65.4020603@gentoo.org>
References: <cmikie$vif$1@sea.gmane.org> <200411061624.57918.dsd@gentoo.org>
	 <cmkkd8$dm8$1@sea.gmane.org>  <419CEC65.4020603@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100794985.6018.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 16:23:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-18 at 18:39, Daniel Drake wrote:
> Some Gentoo users have reported that commands such as ED/EB/E9/F5 are being 
> rejected. When inspecting the cdrecord source code, it seems that these are 
> specific to plextor drives. These drives are MMC but have a few 
> vendor-specific extensions. How should we go about permitting cases like this 
> in the command filter?

Someone posted a very nice patch that added a little fs so you could
adjust the tables from user space. I'd suggest that. Unfortunately its
not been merged with the base kernel yet

