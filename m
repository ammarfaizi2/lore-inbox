Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTJ1B1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTJ1B1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:27:25 -0500
Received: from palrel12.hp.com ([156.153.255.237]:12200 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263810AbTJ1B1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:27:24 -0500
Date: Mon, 27 Oct 2003 17:27:22 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: status of ipchains in 2.6?
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently discovered that ipchains is rather broken.  I noticed the
problem on ia64, but suspect that it's likely to affect all 64-bit
platforms (if not 32-bit platforms).  A more detailed description of
the problem I'm seeing is here:

	http://tinyurl.com/sm9d

Unlike ipchains, iptables works perfectly fine, so perhaps we just
need to update Kconfig to discourage ipchains on ia64 (and/or other
64-bit platforms)?

	--david
