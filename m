Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbRCATSW>; Thu, 1 Mar 2001 14:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129820AbRCATRk>; Thu, 1 Mar 2001 14:17:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7695 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129816AbRCATQv>; Thu, 1 Mar 2001 14:16:51 -0500
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
To: reiser@namesys.com (Hans Reiser)
Date: Thu, 1 Mar 2001 19:19:55 +0000 (GMT)
Cc: smurf@osdlab.org (Nathan Dabney),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A9E96A6.41D725A3@namesys.com> from "Hans Reiser" at Mar 01, 2001 09:36:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YYcH-0008NK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I can't get information about BSD v. Linux 2.4 networking code, then reiserfs
> has to get ported to BSD which will be both nice and a pain to do.

I dont think raw network data helps. 2.2 and FreeBSD are basically the same
speed for raw networking in the general case. So if someone was seeing real
Linux/BSD differences Im concerned it might be a driver but also that it
might not have been networking differences but perhaps VM or disk I/O
performance. Clearly they saw something since its rather hard to mess up
that kind of measuring. I wonder if it was networking though.

The extreme answer to the 2.4 networking performance is the tux specweb
benchmarks but they dont answer for all cases clearly.

Alan

