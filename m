Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVBSSXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVBSSXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 13:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVBSSXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 13:23:35 -0500
Received: from ns1.openconsultancy.com ([207.166.203.131]:13444 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id S261764AbVBSSXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 13:23:34 -0500
X-Spam-Report: SA TESTS
 -3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
 -2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  0.9 AWL                    AWL: From: address is in the auto white-list
Message-ID: <42178422.6000106@davidcoulson.net>
Date: Sat, 19 Feb 2005 13:23:30 -0500
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: bzolnier@elka.pw.edu.pl
Subject: IDE patch to fix Promise 202xx_new
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was having lots of DMA problems with a Promise 20269 PCI IDE 
controller under 2.6.11-rc4, which made it pretty useless. I found the 
following patch from almost two years ago, which when applied resolved 
the problems:

http://www.cs.helsinki.fi/linux/linux-kernel/2003-19/1192.html

Is there a reason I'm unaware of why this never made it into the main 
kernel tree? I've not noticed any ill-effects of applying the patch to 
2.6.11-rc4.

Thanks,
David
