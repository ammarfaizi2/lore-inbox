Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbTDBWpX>; Wed, 2 Apr 2003 17:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263182AbTDBWpX>; Wed, 2 Apr 2003 17:45:23 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:21265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263181AbTDBWpX>; Wed, 2 Apr 2003 17:45:23 -0500
Date: Wed, 2 Apr 2003 23:56:48 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Why moving driver includes ?
In-Reply-To: <1048857524.12125.2.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0304022355170.3919-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi James !
> 
> Why did you move the driver includes to include/video ? What is 
> the reasoning here ?
> 
> For example, drivers/video/radeon.h moved to include/video/radeon.h
> 
> Is this to be able to share register definitions with the DRM drivers ?
> (I doubt this will ever happen as the DRM is rather self contained)

Yes. You never know. The other big reason was so userland could have a 
standard set of hardware header files to program graphics hardware. Now 
SDL and directfb etc can use the same header files.
 

