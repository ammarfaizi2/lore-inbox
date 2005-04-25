Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVDYHm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVDYHm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 03:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVDYHm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 03:42:57 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:37277 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262555AbVDYHmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 03:42:50 -0400
In-Reply-To: <20050422190527.GA2359@infradead.org>
Subject: Re: [patch 10/12] s390: remove ioctl32 from dasdcmb.
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF3AF6AFBF.50033D62-ONC1256FEE.00295572-C1256FEE.002A5318@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 25 Apr 2005 09:42:17 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 25/04/2005 09:42:48
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote on 04/22/2005 09:05:27 PM:

> On Fri, Apr 22, 2005 at 05:02:38PM +0200, Martin Schwidefsky wrote:
> > +#if defined(CONFIG_DASD_CMB) || defined(CONFIG_DASD_CMB_MODULE)
> > +COMPATIBLE_IOCTL(BIODASDCMFENABLE)
> > +COMPATIBLE_IOCTL(BIODASDCMFDISABLE)
> > +COMPATIBLE_IOCTL(BIODASDREADALLCMB)
> > +#endif
>
> I don't think that there should be ifdefs for COMPATIBLE_IOCTL entries.
>

Then it stand to reason to remove ALL the ifdefs in arch/s390/kernel/compat_ioctl.c

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

