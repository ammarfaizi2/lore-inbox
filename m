Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273051AbTG3RLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273052AbTG3RLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:11:50 -0400
Received: from smtp230.tiscali.dk ([62.79.79.115]:62147 "EHLO
	smtp230.tiscali.dk") by vger.kernel.org with ESMTP id S273051AbTG3RLt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:11:49 -0400
From: Jesper Juhl <jju@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 - mtrr overlaps existing
Date: Wed, 30 Jul 2003 19:15:07 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301915.07792.jju@dif.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all, please CC jju@dif.dk on replies since I'm not subscribed to the 
list.

I'm testing out 2.6.0-test2 at the moment, and I've noticed that since 
switching
to this kernel I'm seeing occasional messages like this one in syslog :

Jul 30 18:17:47 dragon kernel: mtrr: 0xf0000000,0x4000000 overlaps existing 
0xf0000000,0x1000000

This is probaby not a problem, but I'm still currious as to the cause.
Can someone explain to me what the cause of this message is, and if there
is something I should do about it?

With 2.4.18 and 2.4.20 kernels I never saw this message (I don't have logs 
from other kernel versions). With the 2.4 kernels I only see these mtrr 
related
messages (which I don't see with 2.6.0-test2, but that's probably because they
have been removed) :

Jul 30 10:12:17 dragon kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Jul 30 10:12:17 dragon kernel: mtrr: detected mtrr type: Intel

This machine's CPU is a 1.4GHz AMD Athlon (Thumderbird) and the 
motherboard is a ASUS A7M266.
If further details are of interrest, then just ask and I'll provide whatever 
info you need.


Kind regards,

Jesper Juhl <jju@dif.dk>

