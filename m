Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424447AbWKJXXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424447AbWKJXXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 18:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424467AbWKJXXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 18:23:15 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:6584 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1424447AbWKJXXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 18:23:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Neil Brown <neilb@suse.de>
Subject: Re: 2.6.19-rc5-mm1: HPC nx6325 breakage, VESA fb problem, md-raid problem
Date: Sat, 11 Nov 2006 00:20:44 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fbuihuu@gmail.com, adaplas@pol.net, Andi Kleen <ak@suse.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611091642.01453.rjw@sisk.pl> <17748.7163.111098.788069@cse.unsw.edu.au>
In-Reply-To: <17748.7163.111098.788069@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611110020.45408.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 10 November 2006 07:28, Neil Brown wrote:
> On Thursday November 9, rjw@sisk.pl wrote:
> > On Thursday, 9 November 2006 02:04, Rafael J. Wysocki wrote:
> > > > > and the kernel says it cannot mount the root fs (which is on an md-raid).
> > > > 
> > > > hm, there was probably some earlier message which tells us why that
> > > > happened.  Doing a capure-and-compare on the dmesg output would be nice
> > > > (netconsole?)
> > 
> > This happens because of md-change-lifetime-rules-for-md-devices.patch and
> > seems to be a universal breakage.
> 
> Thanks for the report.
> Are you at all interested in confirming that this version of the patch
> works for you?

Yes, it does.

Thanks,
Rafael
