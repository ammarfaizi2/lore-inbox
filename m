Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbSL1Rgf>; Sat, 28 Dec 2002 12:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbSL1Rgf>; Sat, 28 Dec 2002 12:36:35 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:50437 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266228AbSL1Rge>; Sat, 28 Dec 2002 12:36:34 -0500
Date: Sat, 28 Dec 2002 17:44:49 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Richard Henderson <rth@twiddle.net>
cc: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: [Linux-fbdev-devel] [FB PATCH]
In-Reply-To: <20021227150934.A3005@twiddle.net>
Message-ID: <Pine.LNX.4.44.0212281743430.31728-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I got link errors due to a missing fb_blank function.  The best
> I can figure is that you were intending to call the fb_blank 
> fbops hook.  Certainly that seems to work.
> 
> I'm not sure how no one else ran into this. 

Okay that is weird. Yes it was suppose to call fb_blank the function.This 
function exist in fbmem.c and it is even exported for modular fbdev 
drivers. 

