Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWDGIr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWDGIr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 04:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWDGIr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 04:47:57 -0400
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:11199 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932384AbWDGIr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 04:47:57 -0400
Message-ID: <4436273A.9000504@drzeus.cx>
Date: Fri, 07 Apr 2006 10:47:54 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Mikkel Erup <mikkelerup@yahoo.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: sdhci driver produces kernel oops on ejecting the card
References: <20060403221936.58274.qmail@web52113.mail.yahoo.com>
In-Reply-To: <20060403221936.58274.qmail@web52113.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikkel Erup wrote:
> 
> It happens with 2.6.16-git20 as well.
> Attached are the log file and kernel .config
> 

Since it ooopses during umount, I'm guessing that it's a problem
somewhere in mmc_block. I'll try to get some time to look closer at it
during the weekend. Perhaps Russell has some idea until then?

Rgds
Pierre

