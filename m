Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVAGHxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVAGHxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVAGHxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:53:30 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42893 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261304AbVAGHx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:53:29 -0500
In-Reply-To: <20050106232959.693b637c.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] add EXPORT_SYMBOL for irq_exit
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFE5D56B4A.A4E1305B-ONC1256F82.002AB75A-C1256F82.002B5AAA@de.ibm.com>
From: Heiko Carstens <Heiko.Carstens@de.ibm.com>
Date: Fri, 7 Jan 2005 08:53:49 +0100
X-MIMETrack: S/MIME Sign by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 01/07/2005 08:53:32 AM,
	Serialize by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 01/07/2005 08:53:32 AM,
	Serialize complete at 01/07/2005 08:53:32 AM,
	S/MIME Sign failed at 01/07/2005 08:53:32 AM: The cryptographic key was not
 found,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.51HF338 | June 21, 2004) at
 07/01/2005 08:53:51,
	Serialize complete at 07/01/2005 08:53:51
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this patch adds the missing EXPORT_SYMBOL for irq_exit:
> >  *** Warning: "irq_exit" [drivers/s390/net/iucv.ko] undefined!
> 
> Why do s/390 drivers call irq_exit()?

Good question. Seems to be a bug in the iucv driver since irq_exit
might get called twice in an error case.
Just forget my "patch".

Heiko

