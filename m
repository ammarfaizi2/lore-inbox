Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTJ2MlA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 07:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTJ2MlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 07:41:00 -0500
Received: from tartutest.cyber.ee ([193.40.6.70]:18436 "EHLO
	tartutest.cyber.ee") by vger.kernel.org with ESMTP id S262050AbTJ2Mk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 07:40:59 -0500
From: Meelis Roos <mroos@linux.ee>
To: rmocius@auste.elnet.lt, linux-kernel@vger.kernel.org
Subject: Re: PCI Bus error 6290 or 0290
In-Reply-To: <07a801c39e13$a4d1dc90$6e69690a@RIMAS>
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.6.0-test8 (i686))
Message-Id: <E1AEpd5-0000Se-QI@rhn.tartu-labor>
Date: Wed, 29 Oct 2003 14:40:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R> I have installed the latest 2.6.0-test9 kernel and I get this error
R> messages:
R> Oct 29 13:51:39 fw kernel: eth1: PCI Bus error 6290.
R> Oct 29 13:51:39 fw kernel: eth1: PCI Bus error 0290.
R> 
R> The problem is with Realtek (RTL-8139) network card drivers.
[...]
R> Any ideas/solutions?

I had the same problem on a K6-2 with some Asus MB. Both Realtek 8139
and tulip (21140) refused to work in a PCI slot. Realtek gave these
messages, tulip told that send timed out. A quick workaround was to put
the NIC into another PCI slot. I don't know the real reason and I don't
have the specific computer available for additional tests any more.

-- 
Meelis Roos (mroos@linux.ee)
