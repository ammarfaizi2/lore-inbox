Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWJXIFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWJXIFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWJXIFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:05:21 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:20417 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932428AbWJXIE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:04:59 -0400
Date: Tue, 24 Oct 2006 09:04:56 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: WARNING: Do not use with EFI-based (e.g. IA64) systems. Bootloader may get eaten
Message-ID: <20061024080456.GA30505@skynet.ie>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/06 01:56), Andrew Morton didst pronounce:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> 

Due to the issue described here (http://lkml.org/lkml/2006/10/21/61),
any system based on EFI may have issues with their bootloader. As the boot
partition is FAT32 any alteration of files in the EFI partition will
effectively delete them and the machine will need to be recovered via
CD or by booting over the network.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
