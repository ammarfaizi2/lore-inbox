Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUGVG5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUGVG5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 02:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUGVG5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 02:57:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:49599 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264912AbUGVG5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 02:57:11 -0400
Date: Thu, 22 Jul 2004 02:55:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: corbet@lwn.net, bgerst@didntduck.org, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-Id: <20040722025539.5d35c4cb.akpm@osdl.org>
In-Reply-To: <20040721235228.GZ14733@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org>
	<20040721231123.13423.qmail@lwn.net>
	<20040721235228.GZ14733@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> Changes that remove functionally like Greg's patch are hopefully 
> still 2.7 stuff - 2.6 is a stable kernel series and smooth upgrades 
> inside a stable kernel series are a must for many users.

I don't necessarily agree that such changes in the userspace interface
should be tied to the kernel version number, really.  That's a three or
four year warning period, which is unreasonably long.  Six to twelve months
should be long enough for udev-based replacements to stabilise and
propagate out into distributions.

That being said, mid-2005 would be an appropriate time to remove devfs.  If
that schedule pushes things along faster than they would otherwise have
progressed, well, good.


Nothing is cast in stone here btw - we're pushing the envelope, trying new
things, keeping that which works well and reexamining things which perhaps
don't work so well.  Feel free to disagree - we're listening.
