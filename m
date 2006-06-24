Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932966AbWFXHqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbWFXHqd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 03:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933212AbWFXHqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 03:46:33 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:63191 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932966AbWFXHqd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 03:46:33 -0400
Date: Sat, 24 Jun 2006 09:45:46 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: [patch] s390: setup.c cleanup + build fix
Message-ID: <20060624074546.GA10398@osiris.ibm.com>
References: <20060623133122.GJ9446@osiris.boeblingen.de.ibm.com> <20060623231535.b368fbda.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623231535.b368fbda.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   CC      arch/s390/kernel/setup.o
> > arch/s390/kernel/setup.c:83: error: initializer element is not computable at
> >                                     load time
> > arch/s390/kernel/setup.c:83: error: (near initialization for
> >                                     'code_resource.start')
> > Not sure which patch in the -mm tree breaks this, but since this can be
> > considered a cleanup it can be merged anyway.
> > 
> 
> That's strange.

Indeed.

> The linker should be able to handle all that.  I wonder why it didn't.
> 
> And it works for me.  What is "31 bit compilation"?

Switching off CONFIG_64BIT, so that you will get a 31 bit binary.
