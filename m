Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUFJTvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUFJTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUFJTvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:51:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49099 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262794AbUFJTvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:51:21 -0400
Date: Thu, 10 Jun 2004 21:49:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Nyberg <alexn@telia.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A generic_file_sendpage()
Message-ID: <20040610194926.GE4507@openzaurus.ucw.cz>
References: <20040608154438.GK18083@dualathlon.random> <20040608193621.GA12780@holomorphy.com> <1086783559.1194.24.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086783559.1194.24.camel@boxen>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The sendfile() for all file systems remain unusable as it is right now,
> only works for sending data to socket. But that should be as much performance
> enhancing as this yes?
> 
> Please hit me with cluebat for what I'm missing.
> (yes, rebooted between all copying)
> 

...this will also allow COW filesystems and copy-on-server...
It would be nice if it could go in soon, so userspace can
start using it and COW/copy-on-server can be usefull in 2.8...


				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

