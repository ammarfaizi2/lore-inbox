Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbSLEElp>; Wed, 4 Dec 2002 23:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSLEElp>; Wed, 4 Dec 2002 23:41:45 -0500
Received: from havoc.gtf.org ([64.213.145.173]:58525 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267215AbSLEElo>;
	Wed, 4 Dec 2002 23:41:44 -0500
Date: Wed, 4 Dec 2002 23:49:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Parallel build broken in latest BK
Message-ID: <20021205044913.GA30035@gtf.org>
References: <Pine.LNX.4.33.0212042215540.924-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212042215540.924-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 10:23:40PM -0600, Patrick Mochel wrote:
> 
> I typically do 
> 
> $ make -j4 MAKE="make -j4" bzImage

Try the GNU-and-improved:

	make -j4

I just tried that and it works fine.

I think MAKE= is a remnant of the old kbuild.  Shouldn't be needed
anymore since the build doesn't descend into directories the way it used
to.

Also, just plain "make" is preferred now, too :)
It builds bzImage and modules both.

	Jeff



