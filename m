Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269978AbTGRRPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270243AbTGRRPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:15:35 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:19219 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP id S269978AbTGRRPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:15:34 -0400
Date: Fri, 18 Jul 2003 18:30:27 +0100
From: Alasdair Kergon <agk@uk.sistina.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: LVM/device mapper support for 2.6.0-test1?
Message-ID: <20030718183027.A6328@uk.sistina.com>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307181254130.5747@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.53.0307181254130.5747@localhost.localdomain>; from rpjday@mindspring.com on Fri, Jul 18, 2003 at 12:55:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 12:55:02PM -0400, Robert P. J. Day wrote:
>   any pointers to LVM[2] support for 2.6?  that last message
> for LVM and device mapper referred only to 2.4.  thanks.

You should use the patches joe submitted to l-k recently together with
the userspace library and tools in the tarballs on the ftp site.

Snapshots and pvmove are still being ported to 2.6.

Patches:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1023.html
  http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1025.html
  http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1027.html
[remove the blk.h includes now to patch cleanly]

Alasdair

