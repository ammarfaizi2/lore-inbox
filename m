Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWEAOAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWEAOAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWEAOAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:00:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:42212 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932118AbWEAOAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:00:14 -0400
Date: Mon, 1 May 2006 16:00:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
In-Reply-To: <20060430174426.a21b4614.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-		Chapter 5: Functions
>+		Chapter 5: Typedefs
>+
>+Please don't use things like "vps_t".
>+It's a _mistake_ to use typedef for structures and pointers. When you see a
>+	vps_t a;
>+in the source, what does it mean?
>+In contrast, if it says
>+	struct virtual_container *a;
>+you can actually tell what "a" is.
>+
>+Lots of people think that typedefs "help readability". Not so. They are
>+useful only for:
[...]

What about task_t vs struct task_struct? Both are used in the kernel.



Jan Engelhardt
-- 
