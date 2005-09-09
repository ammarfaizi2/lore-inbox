Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVIIMlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVIIMlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVIIMlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:41:22 -0400
Received: from [212.76.85.205] ([212.76.85.205]:517 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751376AbVIIMlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:41:21 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-net@vger.kernel.org
Subject: Physical device to Kernel-netlink mapper
Date: Fri, 9 Sep 2005 15:38:27 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200509091538.27605.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a virtual device that would allow to connect the communication paths 
from the physical devs into the kernel netlink subsystem in a way that would 
be more flexible than what is currently avaible?

Something like this:

    Kernel-netlink
        |
    virtual dev
        |
--> mapper/conf <--
        |
    physical dev(s)

tun/tap,bridge,bond... are devs that incorporate this idea, but don't allow 
for a flexible configuration.

Thanks!


