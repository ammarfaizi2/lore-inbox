Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTFFOEA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTFFOEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:04:00 -0400
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:41282 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id S261589AbTFFOD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:03:59 -0400
Date: Fri, 6 Jun 2003 10:18:22 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: make allyesconfig broken in 2.5.70-bk10 and -bk11
Message-ID: <Pine.LNX.4.53.0306061009530.28886@jake.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make allyesconfig hangs just after displaying the following:

<-- SNIP -->
*
* Security options
*
Enable different security models (SECURITY) [N/y/?] (NEW) y
  Socket and Networking Security Hooks (SECURITY_NETWORK) [N/y/?] (NEW) y
  Default Linux Capabilities (SECURITY_CAPABILITIES) [N/m/y/?] (NEW) y
  Root Plug Support (SECURITY_ROOTPLUG) [N/m/y/?] (NEW) y
*
* Cryptographic options
*
-----
make allyesconfig works just fine for -bk9.

John Kim

