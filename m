Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132724AbRDDAeX>; Tue, 3 Apr 2001 20:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRDDAeN>; Tue, 3 Apr 2001 20:34:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52234 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132726AbRDDAd7>; Tue, 3 Apr 2001 20:33:59 -0400
Subject: Re: a quest for a better scheduler
To: fabio@chromium.com (Fabio Riccardi)
Date: Wed, 4 Apr 2001 01:35:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3ACA6BF4.9A3F93A2@chromium.com> from "Fabio Riccardi" at Apr 03, 2001 05:33:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kbH2-0000qX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for the "normal case" performance see my other message.

I did - and with a lot of interest

> I agree that a better threading model would surely help in a web server, but to
> me this is not an excuse to live up with a broken scheduler.

The problem has always been - alternative scheduler, crappier performance for
2 tasks running (which is most boxes). If your numbers are right then the
HP patch is working as well for 1 or 2 tasks too

> Unless we want to maintain the position tha the only way to achieve good
> performance is to embed server applications in the kernel, some minimal help
> should be provided to goodwilling user applications :)

Indeed. I'd love to see you beat tux entirely in userspace.  It proves the
rest of the API for the kernel is right


