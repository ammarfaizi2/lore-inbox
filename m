Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbTGJN62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbTGJN62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:58:28 -0400
Received: from marco.bezeqint.net ([192.115.106.37]:11702 "EHLO
	marco.bezeqint.net") by vger.kernel.org with ESMTP id S266344AbTGJN61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:58:27 -0400
Date: Thu, 10 Jul 2003 17:13:06 +0300
From: gigag@bezeqint.net
Subject: Re: Known problems for 3.5/0.5 virtual space split???
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com
X-Mailer: Webmail Mirapoint Direct 3.3.3-GR
MIME-Version: 1.0
Message-Id: <326f09b6.a1426ae1.817ca00@mas3.bezeqint.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Also, if you can try 2.5-mjb tree, that should have a forward port of
>the same concept ... does it work there?
Yes, it worked with 2.5.70 kernel with the proper mjb patch. I had 
to change root=LABEL=/ token to root=/dev/sda2 one in order to 
make the system boot from SCSI disk. Also, I compiled AIC7XXX 
drivers statically into the kernel.

I tried to do the same trick for 2.4.21 kernel, but it seemed not to 
help. I didn't play with it for too long though. I indend to experiment 
with 2.4.21 kernel in about a week after I finish with 2.5.70, which 
is currently working for me.

Thanks a lot for the help
Giga
