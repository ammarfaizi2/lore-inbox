Return-Path: <linux-kernel-owner+w=401wt.eu-S1751633AbXANT3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbXANT3P (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbXANT3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:29:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43140 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbXANT3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:29:14 -0500
Subject: Re: allocation failed: out of vmalloc space error treating and
	VIDEO1394 IOC LISTEN CHANNEL =?ISO-8859-1?Q?ioctl=A0failed?= problem
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: theSeinfeld@users.sourceforge.net, linux-kernel@vger.kernel.org,
       libdc1394-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
	 <200701100023.39964.theSeinfeld@users.sf.net>
	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 14 Jan 2007 11:28:53 -0800
Message-Id: <1168802934.3123.1062.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 20:19 +0100, Stefan Richter wrote:
> On 10 Jan, Peter Antoniac wrote:
> [...]
> > Problem is: how to get the VMALLOC_RESERVED value for the kernel that is 
> > running? I couldn't find any standard way to do that (something to apply to 
> > GNU Linux and the like). All the things I could get were the default value 
> > being 128MiB :) and that is it. Now, I could just put 128, but what if 
> > somebody changes that, or in some new distro suddenly decides to make it 
> > different? Even worse, what if it is an old kernel with 64 setting?
> [...]
> 
> Maybe somebody at LKML has answers?

vmalloc space is limited; you really can't assume you can get any more
than 64Mb or so (and even then it's thight on some systems already); it
really sounds like vmalloc space isn't the right solution for your
problem whatever it is (context is lost in the quoted mail)...
can you restate the problem to see if there's a better solution
possible?

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

