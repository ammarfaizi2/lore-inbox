Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSIEACY>; Wed, 4 Sep 2002 20:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSIEACY>; Wed, 4 Sep 2002 20:02:24 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:28918
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316610AbSIEACX>; Wed, 4 Sep 2002 20:02:23 -0400
Subject: Re: writing OOPS/panic info to nvram?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Remco Post <r.post@sara.nl>,
       morten.helgesen@nextframe.net, linux-kernel@vger.kernel.org
In-Reply-To: <15734.39068.766611.169333@argo.ozlabs.ibm.com>
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl>
	<20020904140856.GA1949@werewolf.able.es>
	<1031149539.2788.120.camel@irongate.swansea.linux.org.uk> 
	<15734.39068.766611.169333@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 01:07:01 +0100
Message-Id: <1031184421.2796.161.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 00:34, Paul Mackerras wrote:
> IDE was relatively straightforward since you can do basic block I/O
> with just the ATA-1 or ATA-2 registers and command set and PIO.  In
> contrast, I believe SCSI defeated him. :)

You have to reset and retune the interface/controller registers as well,
otherwise bad things can happen. Rusty will be happy to know that next
generation SATA drops the PIO interface for a demented PIO via DMA setup
8)

