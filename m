Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUHGXoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUHGXoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUHGXoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:44:12 -0400
Received: from the-village.bc.nu ([81.2.110.252]:46276 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264767AbUHGXoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:44:10 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091916508.19077.24.camel@localhost.localdomain>
References: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
	 <1091916508.19077.24.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091918494.19079.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 23:41:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-07 at 23:08, Alan Cox wrote:
> On some Dell storage arrays for example the disks are
> bus 0, target 0..4  bus 1, target 0..4 - until that is the cleaner
> trips over one of the SCSI cables at which point it becomes bus 0, 
> lun 0...9, live, while running.

bus 0 target 0..9 I mean of course..

