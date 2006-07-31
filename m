Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWGaR4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWGaR4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGaR4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:56:23 -0400
Received: from blinkenlights.ch ([62.202.0.18]:62317 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S1030297AbWGaR4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:56:23 -0400
Date: Mon, 31 Jul 2006 19:56:21 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: vonbrand@inf.utfsm.cl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
Message-Id: <20060731195621.367ed702.reiser4@blinkenlights.ch>
In-Reply-To: <20060731165406.GA8526@merlin.emma.line.org>
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>
	<20060731165406.GA8526@merlin.emma.line.org>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well - easy to fix, newfs again with proper inode density (perhaps 1 per
> 2 kB) and redo the migration.

Ehr: Such a migration (on a very busy system) takes *some* time (weeks).
Re-Doing (migrate users back / recreate the FS / start again) the whole
thing isn't really an option..


> Of course you're free to pay for a new
> file system if your fellow admin can't be bothered to remember newfs's
> -i option.

Let's face it: Shit happens and nobody is perfect. A filesystem should
be flexible (modern..) and support Admin/User-needs.

We wouldn't need ECC / Raid / UPS's in a perfect world.

 
> > Have you ever seen VxFS or WAFL in action?
> 
> No I haven't. As long as they are commercial, it's not likely that I
> will.

Why?

NetApp WAFL-Blurb:
 http://www.netapp.com/library/tr/3002.pdf
 

Maybe we should crop the Cc: list .. this is getting OT.

 -- Adrian

