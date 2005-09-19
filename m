Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVISJAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVISJAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVISJAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:00:21 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:41416 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932386AbVISJAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:00:19 -0400
Date: Mon, 19 Sep 2005 10:59:42 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 6/7] s390: ipl device.
Message-ID: <20050919085942.GA8057@osiris.boeblingen.de.ibm.com>
References: <20050914155509.GE11478@skybase.boeblingen.de.ibm.com> <20050915171718.GA9833@kroah.com> <20050916071444.GA11851@osiris.boeblingen.de.ibm.com> <20050916213914.GA13807@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916213914.GA13807@kroah.com>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Export the ipl device settings to userspace via the sysfs:
> > > >  * /sys/kernel/ipl_device
> > > What?  Why that location?  Why not in the proper location for your
> > > device, on your bus?
> > 
> > This interface tells from where the kernel was booted from.
> 
> Then why not use /sys/firmware/ipl/ ?  That matches the
> /sys/firmware/edd usage we currently have on x86 boxes.

Ok, I will do the changes. Thanks for reviewing!

Heiko
