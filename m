Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267308AbUBNAs5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267309AbUBNAs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:48:57 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38580 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267308AbUBNAsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:48:55 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Timothy Miller <miller@techsource.com>
Subject: Re: IDE DMA problem  [WAS: Re: Getting lousy NFS + tar-pipe throughput on 2.4.20]
Date: Sat, 14 Feb 2004 01:54:54 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Balaji Calidas <balaji@techsource.com>
References: <402D6262.90301@techsource.com> <402D68CB.2030803@techsource.com>
In-Reply-To: <402D68CB.2030803@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402140154.54307.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 of February 2004 01:16, Timothy Miller wrote:
> I have discovered one major problem that I didn't think to check
> before.  I have never before had trouble using DMA with WD drives, VIA
> chipsets, or RH9, so I didn't think to check before, but hdparm reports
> that DMA is disabled for the disk on the workstation I mentioned in my
> earlier post.
>
> So, I tried this:
>     hdparm -d1 /dev/hda
>
> And I got this result:
> /dev/hda:
>  Setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma = 0 (off)
>
> How do I fix this?  Do I have to unmount the filesystem before I can
> change the dma setting?  Why would it be off to begin with?  I know that
> the BIOS is set up right.  Does 2.4.20 not work well with the KT600
> chipset?

It doesn't, upgrade to 2.4.24.

