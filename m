Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263068AbTCYRPC>; Tue, 25 Mar 2003 12:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbTCYRPC>; Tue, 25 Mar 2003 12:15:02 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:14861 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263068AbTCYRPB>; Tue, 25 Mar 2003 12:15:01 -0500
Date: Tue, 25 Mar 2003 17:26:10 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jan Dittmer <j.dittmer@portrix.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with rivafb again
In-Reply-To: <3E802909.7020200@portrix.net>
Message-ID: <Pine.LNX.4.44.0303251723480.3789-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm getting plenty of those when switch from X (nv driver) to console 
> (rivafb) since your latest code got merged in bk. Also, the console 
> screen is really corrupted when switching back from X (sort of worked 
> before) and the little penguin isn't drawn anymore at bootup time.

Do you have "UseFBdev" in your XF96Config file? You need to enable that 
otherwise X and fbdev will conflict when setting the hardware. As for the 
little penguin you need need to enable the Logo code in the video menu. 
The logo code is also used by the SGI Newport driver.


