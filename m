Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S271511AbUJVQoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271511AbUJVQoN (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 22 Oct 2004 12:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271516AbUJVQoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:44:12 -0400
Received: from fisek2.ada.net.tr ([195.112.153.19]:49348 "EHLO
	embriyo.fisek.com.tr") by vger.kernel.org with ESMTP
	id S271511AbUJVQoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:44:10 -0400
Date: Fri, 22 Oct 2004 19:44:06 +0300
From: Onur Kucuk <onur@delipenguen.net>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: pp@ee.oulu.fi, galibert@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Buggy DSDTs policy ?
Message-Id: <20041022194406.330004e1.onur@delipenguen.net>
In-Reply-To: <1098459316.31003.93.camel@gonzales>
References: <20041022122326.GA69381@dspnet.fr.eu.org>
	<20041022174154.2ebd2c5c.onur@delipenguen.net>
	<1098456935.31003.77.camel@gonzales>
	<20041022151943.GA16874@ee.oulu.fi>
	<1098459316.31003.93.camel@gonzales>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Xavier Bestel wrote:

> Le ven 22/10/2004 à 17:19, Pekka Pietikainen a écrit :
> > On Fri, Oct 22, 2004 at 04:55:35PM +0200, Xavier Bestel wrote:
> > > >  CONFIG_ACPI_CUSTOM_DSDT is included in 2.6.9
> > > 
> > > But fixed DSDTs are a pain to find, and fixing a buggy DSDT is
> > > impossible for a non-hacker.
> > > 
> > http://acpi.sourceforge.net/dsdt/index.php has quite a few.
> 
> .. which aren't all proper fixes (I tried the DSDT for Armada 1700,
> it's a partial fix only).

 This can be an issue to work on. I am sure acpi people won't reject
proper fixes.

 
> > The problem is getting the fixed dsdt in use without recompiling
> > your kernel, since quite a few people, especially non-technical
> > ones, use vendor kernels. There's an approach that uses initrd, but
> > this isn't merged yet. I'd say it should be, assuming no better
> > solution can be found.

 The initrd approach seems nicer and more customisable. 


> Yes, sure. But real non-technical people won't replace their DSDT
> either.

 Real non-technical people follow their distros. They don't need to
recompile a kernel of their own. It is a distro's job for them.


-- 
 Onur Kucuk                                        Knowledge speaks,   
 <onur.--.-.delipenguen.net>                       but wisdom listens  

