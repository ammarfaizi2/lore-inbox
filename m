Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161263AbWHJN2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWHJN2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161315AbWHJN2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:28:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22927 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161312AbWHJN16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:27:58 -0400
Date: Thu, 10 Aug 2006 15:27:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <44DB3151.8050904@garzik.org>
Message-ID: <Pine.LNX.4.64.0608101519560.6762@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
 <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home>
 <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
 <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home>
 <44DB3151.8050904@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Jeff Garzik wrote:

> > Considering the amount of complexity we add for the high end, why is it
> > suddenly a bad thing to add even a _little_ complexity for the other end?
> 
> This is ext4 not ext3 we're talking about.  The next gen Linux filesystem
> should be tuned for modern machines -- 64bit, moving forward -- while still
> working just fine on 32bit.

If you force everyone to use 64bit sector numbers, I don't understand how 
you can claim "still working just fine on 32bit"?
At some point ext4 is probably going to be the de facto standard, which 
very many people want to use, because it has all the new features, which 
won't be ported to ext2/3. So I still don't understand, what's so wrong 
about a little tuning in both directions?

bye, Roman
