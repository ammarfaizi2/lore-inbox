Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWKEN0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWKEN0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 08:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWKEN0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 08:26:15 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:50560 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S932614AbWKEN0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 08:26:14 -0500
Date: Sun, 5 Nov 2006 15:26:07 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Lorenz <martin@lorenz.eu.org>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
Message-ID: <20061105132607.GA14245@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061105064801.GV13381@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061105064801.GV13381@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Adrian Bunk <bunk@stusta.de>:
> Subject    : ThinkPad T60/X60: lose ACPI events after suspend/resume
> References : http://lkml.org/lkml/2006/10/10/39
>              http://lkml.org/lkml/2006/10/4/425
>              http://lkml.org/lkml/2006/10/16/262
>              http://bugzilla.kernel.org/show_bug.cgi?id=7408
>              http://lkml.org/lkml/2006/10/30/251
>              http://lkml.org/lkml/2006/11/3/244
> Submitter  : Martin Lorenz <martin@lorenz.eu.org>
>              "Michael S. Tsirkin" <mst@mellanox.co.il>
> Status     : problem is being debugged

Add to that
http://lkml.org/lkml/2006/11/1/84
and a patch in
http://lkml.org/lkml/2006/11/1/294

I have been running f9dadfa71bc594df09044da61d1c72701121d802 which hs this patch
for several days now and this issue seem to be fixed.

I plan to re-test on -rc5 when that's out.

-- 
MST
