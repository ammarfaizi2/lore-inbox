Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVEBS4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVEBS4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 14:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVEBS4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 14:56:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261635AbVEBSz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 14:55:56 -0400
Date: Mon, 2 May 2005 11:55:50 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Support multiply-LUN devices in ub
Message-Id: <20050502115550.64531666.zaitcev@redhat.com>
In-Reply-To: <20050502174523.GA23669@one-eyed-alien.net>
References: <20050501160540.5b2f4e61.zaitcev@redhat.com>
	<20050502040505.GA6914@one-eyed-alien.net>
	<20050501212438.08ae67f1.zaitcev@redhat.com>
	<20050502174523.GA23669@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005 10:45:23 -0700, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

> I've seen 5 and 6 LUNs, but they aren't common.
> 
> The best reading of the specs suggest that 8 is the practical limit.
> 
> Since that's not far from 4, perhaps it would be best to set the number to
> 8 so we never have to revisit it again.

OK, how about I change it to 9 just to show that it's arbitrary? As long
as it's 2 times smaller than 26, there should be no problem, I think.
I don't want to resend for such a small issue, so I'll wait until
it turns around and change it.

I am going to remove it completely when I revisit the naming and 26
devices limitation.

-- Pete
