Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUAMXK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUAMXK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:10:56 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:56533 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265910AbUAMXKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:10:49 -0500
Date: Tue, 13 Jan 2004 23:09:04 +0000
From: Dave Jones <davej@redhat.com>
To: Jens David <dg1kjd@afthd.tu-darmstadt.de>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powernow-k7 settling time
Message-ID: <20040113230904.GN14674@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jens David <dg1kjd@afthd.tu-darmstadt.de>, hpa@zytor.com,
	linux-kernel@vger.kernel.org
References: <200401132239.i0DMddeK027814@mailserver2.hrz.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401132239.i0DMddeK027814@mailserver2.hrz.tu-darmstadt.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:39:39PM +0100, Jens David wrote:

 > Patch against linux-2.4.24-0pre2.1mdk from current Mandrake Cooker.
 > Should apply cleanly to powernow-patched vanilla-2.4.x as well. Probably
 > relevant for Linux-2.6, too.

2.6 fixed this a few months back, in a different way.
(The code misinterpreted the spec back then, so we were doing
 all sorts of sillyness).

If Mandrake are still running the old version of the driver in their
update kernel, you might want to bug them about it, as there have been
numerous updates since then fixing lots of bugs.

		Dave

