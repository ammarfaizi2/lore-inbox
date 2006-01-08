Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWAHNsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWAHNsy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWAHNsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:48:54 -0500
Received: from xenotime.net ([66.160.160.81]:6287 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161040AbWAHNsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:48:54 -0500
Date: Sun, 8 Jan 2006 05:48:51 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Valdis.Kletnieks@vt.edu
Cc: mbuesch@freenet.de, arjan@infradead.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/4] move capable() to capability.h
Message-Id: <20060108054851.57c0f408.rdunlap@xenotime.net>
In-Reply-To: <200601080745.k087j3mU016114@turing-police.cc.vt.edu>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	<200601061218.17369.mbuesch@freenet.de>
	<1136546539.2940.28.camel@laptopd505.fenrus.org>
	<200601061226.42416.mbuesch@freenet.de>
	<20060107215106.38d58bb9.rdunlap@xenotime.net>
	<200601080745.k087j3mU016114@turing-police.cc.vt.edu>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Jan 2006 02:45:02 -0500 Valdis.Kletnieks@vt.edu wrote:

> On Sat, 07 Jan 2006 21:51:06 PST, "Randy.Dunlap" said:
> 
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > headers + core:
> > - Move capable() from sched.h to capability.h;
> > - Use <linux/capability.h> where capable() is used
> > 	(in include/, block/, ipc/, kernel/, a few drivers/,
> > 	mm/, security/, & sound/;
> > 	many more drivers/ to go)
> 
> Are there plans for a second patch series to remove sched.h from those
> files that only needed it for capable()?

I thought of that but I don't have a good way of checking it.
What (how) do you suggest going about doing that?

---
~Randy
