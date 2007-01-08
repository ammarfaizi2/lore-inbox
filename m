Return-Path: <linux-kernel-owner+w=401wt.eu-S932177AbXAHWxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbXAHWxc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbXAHWxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:53:31 -0500
Received: from thunk.org ([69.25.196.29]:51177 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177AbXAHWxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:53:31 -0500
Date: Mon, 8 Jan 2007 17:53:24 -0500
From: Theodore Tso <tytso@mit.edu>
To: Ben Greear <greearb@candelatech.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 file system went read-only in 2.6.18.2 (plus hacks)
Message-ID: <20070108225324.GA16474@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Ben Greear <greearb@candelatech.com>,
	Alan <alan@lxorguk.ukuu.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <45A2B9DA.20104@candelatech.com> <20070108220544.0febd10b@localhost.localdomain> <45A2C32D.4080101@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A2C32D.4080101@candelatech.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the filesystem obviously got corrupted.  The only question is
*why* it got corrupted.  It could be memory corruption, or a bug in
your propietary kernel patches, or some kind of hardware issue with
the CF device.  There's really no way to say for sure.

Were there any error messages in the system log from the device
driver?

						- Ted
