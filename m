Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932775AbVJ3BfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbVJ3BfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 21:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbVJ3BfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 21:35:00 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:44978 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932775AbVJ3Be7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 21:34:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cS7808rmRfcrQJd1e0IuAjsk2ILe43WqBM+jQngnbEyd33+HSwi+zHbzx6yOvzZsFR40jEtW4P3hb0Qs2A9QbSCxlSUjo7din+0Gq1maX9+KfnJvFQHabXLgS3CnRqdWvptPVPe1xsToGSZDa/LwwNBrUCDpOiombs615vG+PQM=
Message-ID: <af6853e00510291834uc25e0f4q29af72ab3ef5dcc3@mail.gmail.com>
Date: Sat, 29 Oct 2005 19:34:58 -0600
From: Alex Hsia <xanderhsia@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Odd problems with cdrom not finding media
In-Reply-To: <af6853e00510291832lb64515dt1d5d9a5661fb1ae1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <af6853e00510291831m29c1b817padba0c1c88c81299@mail.gmail.com>
	 <af6853e00510291832lb64515dt1d5d9a5661fb1ae1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets everyone,

 I am running into an odd problem with a NEC-3520AW (firmware 3.06)
attached to a Promise Ultra TX2 100 pci card (pdc20268 kernel driver).
DVD's and DVD-R's seem to be recognized fine when inserted; however
CDs (pressed, cdr, cdrw, audio) are not. I always end up with a
message to effect of "No media found" when trying to use those.

 I googled for quite a bit, but wasn't able to narrow the problem
down. I don't know if it is the promise driver or something in the
ide-cd module. A fair bit of my log looks like the following after
trying various mounting operations.

 cdrom: open failed.
 cdrom_pc_intr, write: dev hdf: flags = REQ_STARTED REQ_PC REQ_QUIET
 sector 0, nr/cnr 0/0
 bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
 cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 hdf: cdrom_pc_intr: The drive appears confused (ireason = 0xd0)
 cdrom: This disc doesn't have any tracks I recognize!

 I am running vanilla-2.6.14-rc2 no enhancements. The drive itself
worked fine in another computer. Any ideas on where to go hunting?
 I can provide lots of info if needed, just give me a idea of what.

 Thanks,

 -A

 Please cc me as I am not subscribed to lkml
