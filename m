Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUDQIEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbUDQIEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:04:16 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25355 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263718AbUDQIEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:04:13 -0400
Date: Sat, 17 Apr 2004 10:04:03 +0200
From: Willy Tarreau <w@w.ods.org>
To: "O.Sezer" <sezero@superonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA support in 2.4.27
Message-ID: <20040417080403.GF596@alpha.home.local>
References: <4080E1A1.7030606@superonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4080E1A1.7030606@superonline.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 10:49:53AM +0300, O.Sezer wrote:
> Comments in  ChangeSet 1.1366 -> 1.1367  say:
> 
> # This adds all the SATA drivers except Intel ICH5/ICH6 ("ata_piix").
> # ata_piix was the cause of all the ____request_resource() and PCI quirk
> # nastiness.  As you can see, without that driver, the patch is nice and
> # clean, and does nothing but add files.
> 
> Shall we people who can stand unclean and ugly trees have a separate
> patch for ata_piix please ;))

It's on Jeff's site : www.kernel.org/pub/linux/kernel/people/jgarzik/libata/
Notice that 2.4.26-bk1-libata1 is fairly smaller than 2.4.26-rc1-libata1 :-)

Willy

