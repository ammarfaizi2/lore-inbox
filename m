Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbSLEFOG>; Thu, 5 Dec 2002 00:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267225AbSLEFOG>; Thu, 5 Dec 2002 00:14:06 -0500
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:37104 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S267224AbSLEFOG>; Thu, 5 Dec 2002 00:14:06 -0500
Date: Wed, 4 Dec 2002 21:21:39 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Parallel build broken in latest BK
Message-ID: <20021205052139.GB17498@ip68-4-86-174.oc.oc.cox.net>
References: <Pine.LNX.4.33.0212042215540.924-100000@localhost.localdomain> <20021205044913.GA30035@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205044913.GA30035@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:49:13PM -0500, Jeff Garzik wrote:
> Try the GNU-and-improved:
> 
> 	make -j4
> 
> I just tried that and it works fine.
> 
> I think MAKE= is a remnant of the old kbuild.  Shouldn't be needed
> anymore since the build doesn't descend into directories the way it used
> to.

AFAIK MAKE= is a remnant of old/non-GNU make's -- even with the old
kbuild, it's unneeded with newer GNU make releases AFAIK.

-Barry K. Nathan <barryn@pobox.com>
