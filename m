Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUCKAPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUCKAPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:15:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:31170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262896AbUCKAPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:15:04 -0500
Date: Wed, 10 Mar 2004 16:17:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-Id: <20040310161703.79e1a03c.akpm@osdl.org>
In-Reply-To: <20040311000507.GE18222@drinkel.cistron.nl>
References: <20040310124507.GU4949@suse.de>
	<20040310130046.2df24f0e.akpm@osdl.org>
	<20040310210207.GL15087@suse.de>
	<c2o212$4h0$1@news.cistron.nl>
	<20040310150542.13d71a39.akpm@osdl.org>
	<20040311000507.GE18222@drinkel.cistron.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>
>  dm.c: protect md->map with a rw spin lock rather than the md->lock
> > semaphore.  Also ensure that everyone accesses md->map through
> > dm_get_table(), rather than directly.
> > 
> >  25-akpm/drivers/md/dm-table.c |    3 +
> >  25-akpm/drivers/md/dm.c       |   88 +++++++++++++++++++++++++-----------------
> 
> .. and this final one on top of it, presumably.
> 
> See https://www.redhat.com/archives/dm-devel/2004-March/msg00036.html

Yup, thanks.  Lots happening.  I'll take a trot through the kernel
maternity ward, see if I can drag out another -mm later today.

