Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUEVJ3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUEVJ3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 05:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUEVJ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 05:29:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:44193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265152AbUEVJ3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 05:29:48 -0400
Date: Sat, 22 May 2004 02:26:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: hch@infradead.org
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-Id: <20040522022639.4a8e1f0e.akpm@osdl.org>
In-Reply-To: <20040522092237.GA3417@infradead.org>
References: <20040522013636.61efef73.akpm@osdl.org>
	<40AF18E7.4040509@pobox.com>
	<20040522092237.GA3417@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch@infradead.org wrote:
>
> On Sat, May 22, 2004 at 05:09:59AM -0400, Jeff Garzik wrote:
> > Andrew Morton wrote:
> > >- Added a new SATA RAID driver from 3ware.  From a quick peek it seem to
> > >  need a little work yet.
> > 
> > 
> > It's not too bad... but it looks more like a 2.2 driver forward ported 
> > to 2.4, than a 2.6.x driver.  Needs some luvin' from the 2.6 scsi api crew.
> > 
> > Overall, it appears to be a message-based firmware engine like 
> > drivers/block/carmel.c, that hides the SATA details in the firmware.
> 
> In addition driver submission should always go through linux-scsi.  Please
> tell them to submit it to linux-scsi so we can have a public review process
> there.

Adam did attempt to cc linux-scsi but at 140kbytes the email probably got
spat out.
