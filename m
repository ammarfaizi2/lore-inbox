Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbTIDS0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbTIDS0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:26:17 -0400
Received: from smtp.terra.es ([213.4.129.129]:31471 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S265465AbTIDSZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:25:38 -0400
Date: Thu, 4 Sep 2003 20:23:19 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
Message-Id: <20030904202319.7f9947c9.diegocg@teleline.es>
In-Reply-To: <3F569641.9090905@cyberone.com.au>
References: <20030902231812.03fae13f.akpm@osdl.org>
	<20030904010852.095e7545.diegocg@teleline.es>
	<3F569641.9090905@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 04 Sep 2003 11:32:49 +1000 Nick Piggin <piggin@cyberone.com.au> escribió:

> Hmm... what's heavy gcc load?

make -j25 with 256 MB RAM.

My X server is reniced at -1; but reniced X to -10 and it didn't helped;
-j15 was better (less swapping) but still I saw various mp3 & mouse skips.
