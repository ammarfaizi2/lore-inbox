Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbTGBFDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 01:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbTGBFDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 01:03:38 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15645 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264709AbTGBFDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 01:03:38 -0400
Date: Tue, 1 Jul 2003 22:18:29 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm3
Message-Id: <20030701221829.3e0edf3a.akpm@digeo.com>
In-Reply-To: <15570000.1057122469@[10.10.2.4]>
References: <20030701203830.19ba9328.akpm@digeo.com>
	<15570000.1057122469@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 05:18:01.0120 (UTC) FILETIME=[4E959A00:01C34059]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> 
> 
> --Andrew Morton <akpm@digeo.com> wrote (on Tuesday, July 01, 2003 20:38:30 -0700):
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm3/
> 
> ;-(
> 
> VFS: Cannot open root device "sda2" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> mm2 works fine.
> 
> Seems like no SCSI drivers at all got loaded ... same config file,
> feral on ISP.

Works OK here.

The config option for the feral driver got gratuitously renamed.  To
CONFIG_SCSI_FERAL_ISP.
