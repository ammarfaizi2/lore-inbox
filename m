Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWFPAUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWFPAUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 20:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWFPAUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 20:20:19 -0400
Received: from a34-mta01.direcpc.com ([66.82.4.90]:420 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1750790AbWFPAUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 20:20:17 -0400
Date: Thu, 15 Jun 2006 20:19:52 -0400
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Ubuntu PATCH] 8250_pnp:  Add support for other Wacom tablets
In-reply-to: <20060615190604.GD8694@flint.arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Message-id: <1150417192.7158.20.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <4491BC77.4040804@oracle.com>
 <20060615190604.GD8694@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 20:06 +0100, Russell King wrote:
> On Thu, Jun 15, 2006 at 01:00:55PM -0700, Randy Dunlap wrote:
> > From: Ben Collins <bcollins@ubuntu.com>
> > 
> > [UBUNTU:8250_pnp] Add support for other Wacom tablets that are around
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=6a242b6c279af7805a6cca8f39dbc5bfe1f78cd1
> > 
> > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> 
> Is there a way to "pick" this change from that git tree and throw it
> directly into another git tree, preserving all the metadata?

You should be able to git-fetch my tree into a stock git tree, and use
git-cherry-pick on the sha to pull it in. This is how I backport
changesets into our tree at least.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

