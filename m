Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbSJVJYL>; Tue, 22 Oct 2002 05:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262372AbSJVJYL>; Tue, 22 Oct 2002 05:24:11 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:44727 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262371AbSJVJYK>; Tue, 22 Oct 2002 05:24:10 -0400
Subject: Re: 2.5.44 : remove STATIC static ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210212131210.900-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210212131210.900-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 10:46:22 +0100
Message-Id: <1035279982.31979.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 02:35, Frank Davis wrote:
> drivers/scsi/53c700.c
> drivers/scsi/NCR_D700.c
> drivers/scsi/advansys.c
> fs/xfs/linux/xfs_linux.h
> init/do_mounts.c
> 
> Is this macro really needed (for some reason that escapes me), or can we 
> remove this macro? It seems to serve as to 'hide' a common keyword. 

Some people used to use it so get debugger visible symbols for static
variables when debugging code. That era has gone.

