Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVAUWUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVAUWUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVAUWUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:20:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23725 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262563AbVAUWGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:06:53 -0500
Subject: Re: Fix ea-in-inode default ACL creation
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Tridgell <tridge@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1106344121.19651.55.camel@winden.suse.de>
References: <1106245344.15959.13.camel@winden.suse.de>
	 <1106343376.1989.437.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1106344121.19651.55.camel@winden.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106345195.1989.459.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 21 Jan 2005 22:06:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-01-21 at 21:48, Andreas Gruenbacher wrote:

> Well, we could split EXT3_STATE_NEW into a "GOOD_OLD_NEW" flag for the
> first 128 bytes and a "BIG_INODE_NEW" flag for the rest, and only
> initialize the rest in the xattr code when necessary. Not any better it
> I suppose. 

Agreed. :-)

--Stephen

