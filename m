Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVAFPrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVAFPrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVAFPrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:47:48 -0500
Received: from dialpool1-19.dial.tijd.com ([62.112.10.19]:13191 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262861AbVAFPrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:47:43 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: ARP routing issue
Date: Thu, 6 Jan 2005 16:47:44 +0100
User-Agent: KMail/1.7.2
Cc: linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501061647.45226.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lists,

Sorry to bother you with this probably beat-to-death issue, but I can't figure 
out the solution to the problem.

It's perfectly described in this archive thread:

http://www.uwsg.iu.edu/hypermail/linux/net/0308.1/0071.html

Basically it comes down to this:

I have an IBM server running RH ES, kernel 2.4.9-e.49. It has two interfaces:
eth0 10.0.22.xxx 
eth1 10.0.24.xxx

default gateway is set to 10.0.22.1, on eth0.

Problem is, if I try to ping from another network (10.216.0.xx) to 10.0.24.xx, 
i see the following ARP request:

arp who-has 10.0.22.1 tell 10.0.24.xx

which, imo, is wrong.

I know it has to do with the default gatway, but I can't devise a way to make 
it actually _WORK_.

Any pointers?

Thanks.

Jan
-- 
No one can feel as helpless as the owner of a sick goldfish.
