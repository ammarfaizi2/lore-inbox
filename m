Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTLIKk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTLIKk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:40:59 -0500
Received: from intra.cyclades.com ([64.186.161.6]:26580 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262114AbTLIKkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:40:19 -0500
Date: Tue, 9 Dec 2003 08:31:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Per Andreas Buer <perbu@linpro.no>
Cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4: mylex and > 2GB RAM
In-Reply-To: <1070917304.1260.44.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0312090830270.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, Per Andreas Buer wrote:

> On Mon, 2003-12-08 at 21:22, William Lee Irwin III wrote:
> >
> > It could potentially slow it down a lot more than a few percent.
> > 
> > The main effect you would see is heavy low memory consumption (LowFree:
> > going down to almost nothing) and very heavy cpu consumption.
> 
> Right on. LowFree drops and when it reaches almost nothing the system
> more or less goes freezes. 
> 
> The DAC960 driver is not a SCSI driver so this means that there is
> something wrong with the PCI-DMA transfers, right?
> 
> Replacing the DAC960 with another RAID-kontroller will not help because
> it will use the same PCI-DMA transfers, right? Any hints on how I can
> mend this?

Per, 

You may want to give 2.4.23 a try. 

The VM has been changed to balance the memory in a "saner" way wrt 
highmem. 


