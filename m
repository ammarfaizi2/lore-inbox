Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289124AbSAGFQC>; Mon, 7 Jan 2002 00:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289123AbSAGFPu>; Mon, 7 Jan 2002 00:15:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:6652 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S289120AbSAGFPn>;
	Mon, 7 Jan 2002 00:15:43 -0500
Date: Mon, 7 Jan 2002 15:52:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Hood <jdthood@mail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Andreas Steinmetz <ast@domdv.de>,
        Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        linux-laptop@vger.kernel.org, <laslo@wodip.opole.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Combined APM patch
Message-Id: <20020107155226.5c6409b6.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is my version of the combined APM patches;

	Change notification order so that user mode is notified
		before drivers of impending suspends.
	Move the idling back into the idle loop.
	A couple of small tidy ups.

See header comments for attributions.

This works for me (including as a module).

Please test and let me know - it seems to lower my power requirements
by about 10% on my Thinkpad (over stock 2.4.17).

http://www.canb.auug.org.au/~sfr/2.4.17-APM.1.diff

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
