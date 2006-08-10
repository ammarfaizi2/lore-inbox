Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161490AbWHJNJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161490AbWHJNJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161484AbWHJNJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:09:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:44942 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161292AbWHJNJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:09:08 -0400
Date: Thu, 10 Aug 2006 15:08:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <44DB27A3.1040606@garzik.org>
Message-ID: <Pine.LNX.4.64.0608101459260.6761@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
 <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home>
 <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
 <44DB27A3.1040606@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Jeff Garzik wrote:

> > > Or you could just not bother, and leave everything as u64.
> > 
> > Why?
> 
> To eliminate needless complexity and keep things simple and obvious?

Considering the amount of complexity we add for the high end, why is it 
suddenly a bad thing to add even a _little_ complexity for the other end?

bye, Roman
