Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262967AbTC1NG6>; Fri, 28 Mar 2003 08:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262968AbTC1NG6>; Fri, 28 Mar 2003 08:06:58 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:18114 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S262967AbTC1NG5>;
	Fri, 28 Mar 2003 08:06:57 -0500
Subject: Why moving driver includes ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048857524.12125.2.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Mar 2003 14:18:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James !

Why did you move the driver includes to include/video ? What is 
the reasoning here ?

For example, drivers/video/radeon.h moved to include/video/radeon.h

Is this to be able to share register definitions with the DRM drivers ?
(I doubt this will ever happen as the DRM is rather self contained)

I would have preferred those includes to stay next to their respective
drivers (though renaming radeon.h to radeonfb.h might have made some
sense).

Regards,
Ben.

