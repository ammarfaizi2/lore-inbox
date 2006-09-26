Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWIZTji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWIZTji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWIZTjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:39:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932492AbWIZTj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:39:26 -0400
Date: Tue, 26 Sep 2006 12:38:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 4/6] swsusp: Add resume_offset command line
 parameter
Message-Id: <20060926123859.34e9b913.akpm@osdl.org>
In-Reply-To: <200609231208.25670.rjw@sisk.pl>
References: <200609231158.00147.rjw@sisk.pl>
	<200609231208.25670.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 12:08:25 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Add the kernel command line parameter "resume_offset=" allowing us to specify
> the offset, in <PAGE_SIZE> units, from the beginning of the partition pointed
> to by the "resume=" parameter at which the swap header is located.

Is this description correct?  I think it's in 512-byte units?

It certainly should be - a filesytem could start the swapfile at any
sector_t.


