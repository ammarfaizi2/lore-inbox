Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161452AbWHJQrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161452AbWHJQrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161453AbWHJQrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:47:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27536 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161449AbWHJQrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:47:37 -0400
Date: Thu, 10 Aug 2006 18:43:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: John Stoffel <john@stoffel.org>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <17627.23974.848640.278643@stoffel.org>
Message-ID: <Pine.LNX.4.64.0608101838050.6762@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
 <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home>
 <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
 <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home>
 <44DB3151.8050904@garzik.org> <Pine.LNX.4.64.0608101519560.6762@scrub.home>
 <17627.23974.848640.278643@stoffel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, John Stoffel wrote:

> The problem as I see it, is that you want extents, but you don't want
> the RAM/DISK/ROM penalty of 64bit blocks, since embedded devices won't
> ever go past the existing ext3 sizes, right?
> 
> Is this a more clear statement of what you want?

This is only about the runtime penalty. I'm less concerned about the disk 
structures, as soon as you use extents it's often more efficient than the 
current structure anyway.

bye, Roman
