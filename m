Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUFYUJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUFYUJx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUFYUJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:09:53 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:9696 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266157AbUFYUJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:09:52 -0400
Date: Fri, 25 Jun 2004 22:09:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alexander Nyberg <alexn@telia.com>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] A generic_file_sendpage()
Message-ID: <20040625200944.GB22290@wohnheim.fh-wedel.de>
References: <20040608154438.GK18083@dualathlon.random> <20040608193621.GA12780@holomorphy.com> <1086783559.1194.24.camel@boxen> <20040625191924.GA8656@wohnheim.fh-wedel.de> <20040625200533.GI31203@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040625200533.GI31203@schnapps.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 June 2004 14:05:33 -0600, Andreas Dilger wrote:
> 
> Yes, it would be nice to get this into the kernel, then eventually have
> "cp" test if sendfile() works between two files.  That would allow things
> like remote file copy for network filesystems, COW, etc much easier.

But as long as the patches are as ugly as mine, this is 2.7 work.  In
case anyone missed it:

http://wohnheim.fh-wedel.de/~joern/cowlink/

Jörn

-- 
To my face you have the audacity to advise me to become a thief - the worst
kind of thief that is conceivable, a thief of spiritual things, a thief of
ideas! It is insufferable, intolerable!
-- M. Binet in Scarabouche
