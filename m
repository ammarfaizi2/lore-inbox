Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVCGLjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVCGLjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVCGLjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:39:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:49615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261342AbVCGLjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:39:45 -0500
Date: Mon, 7 Mar 2005 03:39:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH][3/3] swsusp: use non-contiguous memory
Message-Id: <20050307033905.7efa259e.akpm@osdl.org>
In-Reply-To: <200503071232.32141.rjw@sisk.pl>
References: <200503042051.54176.rjw@sisk.pl>
	<20050307064131.GA31983@hugang.soulinfo.com>
	<200503071232.32141.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Monday, 7 of March 2005 07:41, hugang@soulinfo.com wrote:
> > On Fri, Mar 04, 2005 at 08:51:53PM +0100, Rafael J. Wysocki wrote:
> > > From: Hu Gang <hugang@soulinfo.com>
> > > 
> > > Subject: swsusp: use non-contiguous memory on resume - ppc support
> > > 
> > > This patch contains the architecture-dependent changes for ppc
> > > required for using a linklist instead of an array of page backup entries
> > > during resume.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> >   Signed-off-by: Hu Gang <hugang@soulinfo.com>
> 
> Yes, the Signed-off-by line was missing from the original patch.  Andrew,
> should I resubmit it?
> 

I dropped lots of those swsusp patches due to various bit of breakage. 
Pavel will be redoing all of them sometime, hopefully.

