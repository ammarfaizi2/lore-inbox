Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTI3MXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTI3MXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:23:53 -0400
Received: from rth.ninka.net ([216.101.162.244]:11395 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261376AbTI3MXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:23:52 -0400
Date: Tue, 30 Sep 2003 05:23:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: axboe@suse.de, schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-Id: <20030930052337.444fdac4.davem@redhat.com>
In-Reply-To: <3F797316.2010401@domdv.de>
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de>
	<20030930115411.GL2908@suse.de>
	<3F797316.2010401@domdv.de>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 14:12:06 +0200
Andreas Steinmetz <ast@domdv.de> wrote:

> Then please tell me why PPPIOCNEWUNIT is only defined in linux/if_ppp.h 
> and not net/if_ppp.h which is still true for glibc-2.3.2. And please 
> don't tell me to ask the glibc folks. There are inconsistencies between 
> kernel headers and userland headers which force the inclusion of kernel 
> headers in userland applications.

Indeed, and equally someone tell me where all the IPSEC socket
interface defines are in glibc?  It doesn't matter which tree
you check it won't be there.

Even if one is of the opinion that nobody should be including the
kernel headers, you must fully realize that as a matter of
practicality people absolutely must do this to use many kernel
interfaces to their full extent.

Suggest changes to fix the problems, but just saying "don't include
kernel header in your user apps, NYAH NYAH NYAH!" does not help
anyone at all.

