Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTIFWNG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 18:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTIFWNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 18:13:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:10725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262948AbTIFWNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 18:13:02 -0400
Message-ID: <33266.4.4.25.4.1062886377.squirrel@www.osdl.org>
Date: Sat, 6 Sep 2003 15:12:57 -0700 (PDT)
Subject: Re: [-mm patch] fix IDE pdc4030.c compile
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <bunk@fs.tum.de>
In-Reply-To: <20030906194404.GG14436@fs.tum.de>
References: <20030906194404.GG14436@fs.tum.de>
X-Priority: 3
Importance: Normal
Cc: <akpm@osdl.org>, <rddunlap@osdl.org>, <domen@coderock.org>,
       <linux-kernel@vger.kernel.org>, <B.Zolnierkiewicz@elka.pw.edu.pl>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> init-exit-cleanups.patch in 2.6.0-test4-mm6 made ide_probe_for_pdc4030  in
> drivers/ide/legacy/pdc4030.c static although it's referenced from
> drivers/ide/ide.c resulting in a link error.
>
> The following patch fixes it:

Thanks, I'll test better in the future, and expect submitters
to do so also.

~Randy



