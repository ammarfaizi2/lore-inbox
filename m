Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTICL6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTICL6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:58:35 -0400
Received: from brains.student.utwente.nl ([130.89.161.140]:35203 "EHLO
	brains.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261973AbTICL6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:58:34 -0400
Subject: Re: 2.6 - Kernel panic with GRE tunneling
From: Justin Ossevoort <iq-0@brains.student.utwente.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062590313.9132.49.camel@pulse>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 13:58:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I bet that if you configure the tunnels on both machines, it works.
> Can you reproduce this without VMware?

The original situation was with one of my normal machines (not VMWare),
the tunnel on that system has been operational for some years. The last
kernel before 2.6.0-test3 was 2.5.67-mm1 and it showed no problems. The
other end-point is a 2.4.21 which hasn't changed a bit over the last
period.

After I upgraded, I could ping to the other side, but got no replies. If
the other side ping'd me I got the before mentioned panic. After about
10 such crashes, the tunnel was finally dropped on both sides.

VMWare was used to get the error message (which didn't get logged to
syslog) from the console (without copying it by hand).



