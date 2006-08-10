Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWHJGZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWHJGZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWHJGZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:25:33 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:8949 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1161080AbWHJGZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:25:32 -0400
Date: Thu, 10 Aug 2006 08:25:13 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
Message-ID: <20060810062513.GA12947@aepfle.de>
References: <1155144599.5729.226.camel@localhost.localdomain> <44DA4288.6020806@rtr.ca> <44DACE9F.3090909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44DACE9F.3090909@garzik.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 02:13:51AM -0400, Jeff Garzik wrote:
> Mark Lord wrote:
> >This will also allow time for things like "udev" to perhaps think about
> >an option to someday provide /dev/hd* symlinks for PATA devices when
> >libata is used instead of IDE (?).  That might be a possible migration
> >path in the far future.
> 
> Unfortunately a symlink won't work because of compatibility issues. 
> /dev/hd supports more partitions, and a different set of ioctls.

Is there a dm-$partition.ko that assigns a bunch of dm-N devices per partition table entry?
Or can all that be done from userland, parsing the on-disk partition table and
create dm-N devices to access everything thats accessible now?
