Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUCMBnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 20:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUCMBnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 20:43:06 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:30632 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262541AbUCMBnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 20:43:04 -0500
Date: Fri, 12 Mar 2004 17:42:29 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/10): zfcp log messages part 1.
Message-ID: <20040312174229.A12405@beaverton.ibm.com>
References: <OFF4F1554E.7176B1A5-ONC1256E55.00709267-C1256E55.0070A777@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFF4F1554E.7176B1A5-ONC1256E55.00709267-C1256E55.0070A777@de.ibm.com>; from schwidefsky@de.ibm.com on Fri, Mar 12, 2004 at 09:30:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 09:30:29PM +0100, Martin Schwidefsky wrote:
> 
> 
> 
> 
> Hi Christoph,
> 
> > > zfcp host adapter log message cleanup part 1:
> > >  - Shorten log output.
> > >  - Increase log level for some messages.
> > >  - Always print leading zeroes for wwpn and fcp-lun.
> >
> > Is there any reason zfcp can't use dev_printk, sdev_printk & co?
> 
> Probably. I'll have to ask the scsi folks.

There is no sdev_printk. I liked the patch and the cleanup it provided,
independent of anything else. I think Dan S has given up on pushing it
through again.

-- Patrick Mansfield
