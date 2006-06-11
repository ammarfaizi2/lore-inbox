Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWFKDiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWFKDiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 23:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFKDiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 23:38:17 -0400
Received: from xenotime.net ([66.160.160.81]:8862 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750934AbWFKDiQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 23:38:16 -0400
Date: Sat, 10 Jun 2006 20:41:00 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@vger.kernel.org,
       linux-xfs@oss.sgi.com, ecki@lina.inka.de, lkml@rtr.ca
Subject: Re: Updated sysctl documentation take #2
Message-Id: <20060610204100.901a0de1.rdunlap@xenotime.net>
In-Reply-To: <20060608001806.028ab05a.diegocg@gmail.com>
References: <20060607205316.bbb3c379.diegocg@gmail.com>
	<20060607130653.9a4d572c.rdunlap@xenotime.net>
	<20060608001806.028ab05a.diegocg@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 00:18:06 +0200 Diego Calleja wrote:

> El Wed, 7 Jun 2006 13:06:53 -0700,
> "Randy.Dunlap" <rdunlap@xenotime.net> escribió:
> 
> > OK, that's all for the README file.  I'll look at the rest of it
> > sometime this week.  I don't think that it's quite ready to be merged.
> 
> Thank's for your review, altought I didn't though someone was to review
> so deeply a documentation patch ;) I've gone through all the files and
> fixed the 72-col limit and everything I could. I've updated the patch
> http://terra.es/personal/diegocg/sysctl-docs

Here are some more comments for you.

1.  There are quite a few lines (17) ending with ^M (carriage return)
that should be removed.

2.  Lines like this one should end with a period (full stop):

+This file is SPARC-only

3.  I would put this comment near the top of each file, not at
the end:

+PLEASE KEEP THIS FILE ORDERED ALPHABETICALLY.


Other than that, it's looking good to me.

Thanks,
---
~Randy
