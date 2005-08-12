Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVHLTpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVHLTpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVHLTpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:45:35 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:57220 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751258AbVHLTpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:45:34 -0400
Date: Fri, 12 Aug 2005 15:45:31 -0400
To: Nanakos Chrysostomos <nanakos@wired-net.gr>
Cc: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fdisk & LBA
Message-ID: <20050812194531.GL31019@csclub.uwaterloo.ca>
References: <42FB435E.2070607@effigent.net> <Pine.LNX.4.61.0508110835480.14365@chaos.analogic.com> <47285.62.1.10.150.1123874953.squirrel@webmail.wired-net.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47285.62.1.10.150.1123874953.squirrel@webmail.wired-net.gr>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 10:29:13PM +0300, Nanakos Chrysostomos wrote:
> Hi all,i want to retrieve the partition table of a primary extended
> partition.
> My MBR partition table ,says that the LBA Partition Start sector for the
> extended partition is 10281600.It is the same that i find with my C code
> and through fdisk usage.
> How can i use this value to seek(lseek) to this point through the main
> block file (/dev/hda or /dev/hdb) and read the partition table of the
> logical partition?

Multiply by the sector size (probably 512 bytes).

Len Sorensen
