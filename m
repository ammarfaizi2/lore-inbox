Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbTACKbS>; Fri, 3 Jan 2003 05:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbTACKbS>; Fri, 3 Jan 2003 05:31:18 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:18643 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267480AbTACKbR>;
	Fri, 3 Jan 2003 05:31:17 -0500
Date: Fri, 3 Jan 2003 10:38:16 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: odd phenomenon.
Message-ID: <20030103103816.GA2567@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something strange I've noticed on all recent 2.4 and 2.5 kernels.

If I start galeon whilst I've got a bk pull in operation, the
galeon process starts, opens its window, and then dies instantly.
Starting it a second time works.

Its not OOM, as theres plenty of free RAM, and half gig of free (unused) swap.

It's almost 100% reproducable here.  Only seen it do it on this box
though which is a P4 with HT, so it could be SMP related..

Ideas ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
