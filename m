Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269183AbUINHUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269183AbUINHUX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUINHUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:20:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19074 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269183AbUINHUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:20:18 -0400
Date: Tue, 14 Sep 2004 18:14:40 +1000
From: Nathan Scott <nathans@sgi.com>
To: Marcin Garski <mgarski@post.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Copying huge amount of data on ReiserFS, XFS and Silicon Image 3112 cause oops.
Message-ID: <20040914081440.GC5083@frodo>
References: <414622C9.1030701@post.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414622C9.1030701@post.pl>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 12:44:25AM +0200, Marcin Garski wrote:
> [Please CC me on replies, I am not subscribed to the list, thanks]
> 
> Hello,
> 
> I bought a new HDD Maxtor 6Y160M0 and connected it as hdg to Sil 3112 
> (CONFIG_BLK_DEV_SIIMAGE) on Abit NF7-S V2.0. I also have ST380013AS 
> (with Fedora Core 2 on hde2 and 2.6.5 kernel) as hde.

Possible hardware problems?  Have you run memtest there?

Was 4KSTACKS enabled in those kernels (I think so)? - XFS
has one known problem with that option when running low on
space (patch fixing that is being tested atm) and I think
the reiserfs folks had some 4k stack issues as well at one
point, so that might be another explanation.

cheers.

-- 
Nathan
