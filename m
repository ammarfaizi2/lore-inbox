Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314769AbSENAAN>; Mon, 13 May 2002 20:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314758AbSENAAM>; Mon, 13 May 2002 20:00:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48909 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314769AbSENAAL>; Mon, 13 May 2002 20:00:11 -0400
Subject: Re: InfiniBand BOF @ LSM - topics of interest
To: lmb@suse.de (Lars Marowsky-Bree)
Date: Tue, 14 May 2002 01:19:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        woody@co.intel.com (Woodruff Robert J), linux-kernel@vger.kernel.org,
        zaitcev@redhat.com
In-Reply-To: <20020514012655.G12383@marowsky-bree.de> from "Lars Marowsky-Bree" at May 14, 2002 01:26:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177Q2i-0006iF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2002-05-14T00:42:07,
>    Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> 
> > Kernel mode RPC over infiniband - relevant to mosix type stuff, to McVoy
> > scalable cluster type stuff and also to things like file system offload
> 
> For that, a generic comm interface would be a good thing to have first.

It has to be fast, nonblocking and kernel callable. Cluster people count
individual microseconds so its base layers must be extremely efficient
even if there are "easy use" layers above. The obvious "easy use" layer being
IP over infiniband.

Alan
