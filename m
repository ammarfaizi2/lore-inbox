Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbTDKLPF (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 07:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTDKLPF (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 07:15:05 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:41088 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264084AbTDKLPE (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 07:15:04 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111129.h3BBTASV000780@81-2-122-30.bradfords.org.uk>
Subject: Re: ATAPI cdrecord issue 2.5.67
To: mikpe@csd.uu.se
Date: Fri, 11 Apr 2003 12:29:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <16022.40189.672337.427776@gargle.gargle.HOWL> from "mikpe@csd.uu.se" at Apr 11, 2003 12:46:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Alan Cox writes:
>  > On Thu, 2003-04-10 at 20:53, H. Peter Anvin wrote:
>  > > I think ide-scsi needs to be supported for some time going forward.
>  > > After all, cdrecord, cdrdao, dvdrecord aren't going to be the only
>  > > applications.
>  > 
>  > And far longer than that. People seem to be testing and demoing 
>  > crazy things like SATA attached scanners, printers and even enclosure
>  > services.
> 
> ATAPI tape drives will need ide-scsi too, unless ide-tape somehow
> got repaired lately. And some people already use ide-scsi+st in
> 2.4 since ide-tape doesn't always work reliably.
> 
> ide-scsi isn't just for CD/DVD writers.

How long will it be before somebody develops an ATAPI, SCSI host
adaptor, I.E. a SCSI host adaptor which appears as an ATAPI device?

(I know that ATAPI really is effectively just a SCSI transport, but
you can already get SCSI, SCSI host adaptors, I.E. where the devices
on the second-level adaptor appear as the logical units of the host
adaptor, and there is no reason this couldn't be done using ATAPI).

John.
