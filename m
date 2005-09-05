Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVIEP4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVIEP4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVIEP4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:56:50 -0400
Received: from ipx10069.ipxserver.de ([80.190.240.67]:54214 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S932206AbVIEP4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:56:49 -0400
Date: Mon, 5 Sep 2005 17:56:40 +0200
From: felix-linuxkernel@fefe.de
To: linux-kernel@vger.kernel.org
Subject: igmp problem
Message-ID: <20050905155640.GA18216@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I wrote a few multicast tools, which use these multicast groups:

  225.109.99.112
  ff02::6d63:7030
  224.110.99.112
  ff02::6e63:7030

I have a Cisco in the middle, and both boxes are in different VLANs.
The Cisco is sending out igmp queries.  The kernel never answers, even
after subscribing to these multicast groups.

The kernel version is 2.4.26.  What could be the problem here?

I found no netfilter rules, and the kernel has multicast support (at
least several igmp related sysctls exist).

Felix
