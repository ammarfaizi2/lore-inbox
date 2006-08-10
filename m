Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161261AbWHJOgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161261AbWHJOgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWHJOgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:36:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54159 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161251AbWHJOgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:36:09 -0400
Date: Thu, 10 Aug 2006 16:35:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jeff Garzik <jeff@garzik.org>
cc: Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/9] sector_t format string
In-Reply-To: <44DB4107.5050001@garzik.org>
Message-ID: <Pine.LNX.4.64.0608101631250.6761@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
 <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home>
 <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
 <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home>
 <44DB3151.8050904@garzik.org> <Pine.LNX.4.64.0608101519560.6762@scrub.home>
 <44DB34FF.4000303@garzik.org> <Pine.LNX.4.64.0608101547261.6761@scrub.home>
 <44DB3CED.7080802@sandeen.net> <Pine.LNX.4.64.0608101612390.6761@scrub.home>
 <44DB4107.5050001@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Jeff Garzik wrote:

> > The problem being that it doesn't _exclusively_ address scaling issues, some
> > new features may well be interesting to non high end users as well. If it's
> > supposed to be a high end only fs, then please don't call ext4, otherwise it
> > would mislead users about what it doesn't is - a general purpose fs.
> 
> It will work just fine on 32-bit machines.
> 
> You're making a mountain out of a molehill.

I'm not sure we're talking about the same thing, my initial concern was 
this comment from Andrew: "I'd have thought that we'd just make ext4
depend on 64-bit sector_t and be done with it." This would require LBD and 
I don't think this is "just fine" on 32bit machines.

bye, Roman
