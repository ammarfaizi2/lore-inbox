Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266608AbUAWRif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUAWRif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:38:35 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:56448 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S266608AbUAWRh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:37:57 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16401.23536.363448.1368@jik.kamens.brookline.ma.us>
Date: Fri, 23 Jan 2004 12:37:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Hard lock-ups with 2.6.1-rc1; plus is there an "ac" equivalent for 2.6.x?
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I switched from 2.4.22-ac4 to 2.6.1-rc1 in the hope that perhaps if I
could reproduce the hangs my SIIG SIi680 Ultra ATA 133 controller is
causing in a 2.6.x kernel, the people on this list might be more
forthcoming in suggestions for debugging them (I've received no
responses at all to my request for help debugging the hangs with
2.4.22-ac4).

I've had to switch back to 2.4.22-ac4 because 2.6.1-rc1 regularly,
reliably locks up on me under heavy load.  I don't think this is
related to the IDE controller lockups I'm seeing occasionally under
2.4.22-ac4, because it happens reliably under heavy load and the
lockups under 2.4.22-ac4 weren't nearly as reliable.

Furthermore, even before it looks up, I find that the performance
under heavy load is much slower than 2.4.22-ac4's performance.

I understood how to get the ac kernel patches to make a 2.4.x kernel
into something useful, but I don't know if perhaps there's something
equivalent for 2.6.x kernels which I'm not doing but should be.  Alan
doesn't seem to be putting out patch-sets for recent kernels.  I see
the "mm" kernel mentioned regularly on this list, but I don't know if
that's something I should be using instead of the plain kernel, and if
so, how to get it (for the ac patches, I have looked in
ftp://ftp.kernel.org/pub/linux/kernel/people/alan).

I'd appreciate any help and/or suggestions you can provide.

Thanks,

  jik
