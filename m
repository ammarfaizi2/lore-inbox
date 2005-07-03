Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVGCTYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVGCTYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGCTYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:24:09 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:35679 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261501AbVGCTYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:24:02 -0400
Date: Sun, 3 Jul 2005 21:26:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.12] Add -Wno-pointer-sign to HOSTCFLAGS
Message-ID: <20050703192637.GC8052@mars.ravnborg.org>
References: <20663.1119145803@ocs3.ocs.com.au> <42B623C1.7070004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B623C1.7070004@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 10:02:41PM -0400, Jeff Garzik wrote:
> Keith Owens wrote:
> >Compiling 2.6.12 with gcc 4.0.0 (FC4) gets lots of warnings for the
> >programs in the scripts directory.  Add -Wno-pointer-sign to HOSTCFLAGS
> >to suppress them.
> >
> >Signed-off-by: Keith Owens <kaos@ocs.com.au>
> 
> 
> Although I am a bit nervous about papering over these warnings without 
> addressing them...  I still ACK the patch, because gcc4 on FC4 does 
> indeed spew a bunch of noise.
> 
> Have you (or anyone) looked into the "root cause" of these warnings?
I've receive a few pathes to scripts/ fixing this.
They almost all just used casts to hide the warning but some included
real fixes. They are all lost for now though.

	Sam
