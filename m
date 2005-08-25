Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVHYOP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVHYOP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVHYOP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:15:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:62144 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964999AbVHYOP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:15:57 -0400
Date: Thu, 25 Aug 2005 16:15:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@infradead.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
In-Reply-To: <20050825135933.GA14448@infradead.org>
Message-ID: <Pine.LNX.4.61.0508251610441.3728@scrub.home>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0508251107500.24552@scrub.home>
 <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
 <20050825135933.GA14448@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Aug 2005, Christoph Hellwig wrote:

> Yup.  Let's get m68k into buildable shape for 2.6.13 with Al's minimal
> patches, and if you have further improvements over that submit them as
> split up patches through the usual channels.  Having all architectures
> actually build and work from mainline is really important to have
> useful kernel package in distributions.

No, there has been no discussion of these patches, so there is no point in 
doing this a few days before 2.6.13. Can we please do this properly for 
2.6.14?

If you want to apply these patches, please also apply the following patch:

Index: linux-2.6/MAINTAINERS
===================================================================
--- linux-2.6.orig/MAINTAINERS	2005-08-10 01:45:52.000000000 +0200
+++ linux-2.6/MAINTAINERS	2005-08-25 16:05:41.798908837 +0200
@@ -1511,8 +1511,8 @@ S:	Maintained
 M68K ARCHITECTURE
 P:	Geert Uytterhoeven
 M:	geert@linux-m68k.org
-P:	Roman Zippel
-M:	zippel@linux-m68k.org
+P:	Al Viro
+M:	viro@parcelfarce.linux.theplanet.co.uk
 L:	linux-m68k@lists.linux-m68k.org
 W:	http://www.linux-m68k.org/
 W:	http://linux-m68k-cvs.ubb.ca/


I'm serious about this.

bye, Roman
