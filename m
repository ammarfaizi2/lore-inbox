Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbUJYRMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUJYRMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbUJYRAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:00:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:36746 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261978AbUJYQ7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:59:15 -0400
Date: Mon, 25 Oct 2004 09:59:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com
Subject: Re: [PATCH 2.6] hw_random.c: replace pci_find_device
Message-ID: <20041025095911.Q2441@build.pdx.osdl.net>
References: <268450000.1098383924@w-hlinder.beaverton.ibm.com> <41783CDA.8010901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41783CDA.8010901@pobox.com>; from jgarzik@pobox.com on Thu, Oct 21, 2004 at 06:48:58PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> applied

  CC      drivers/char/hw_random.o
drivers/char/hw_random.c: In function `rng_init':
drivers/char/hw_random.c:584: warning: implicit declaration of function `for_each_pci_dev'
...

Woops, looks like this broke the build, I don't have for_each_pci_dev
anywhere in my tree but one use in hw_random.c and one comment in
SCCS/s.ChangeSet.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
