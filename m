Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUANTVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUANTTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:19:33 -0500
Received: from peabody.ximian.com ([130.57.169.10]:9673 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263228AbUANTRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:17:20 -0500
Subject: Re: Laptops & CPU frequency
From: Robert Love <rml@ximian.com>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: Dave Jones <davej@redhat.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1074107508.4549.10.camel@localhost>
References: <20040111025623.GA19890@ncsu.edu>
	 <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <1073841200.1153.0.camel@localhost>
	 <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
	 <1073843690.1153.12.camel@localhost>  <20040114045945.GB23845@redhat.com>
	 <1074107508.4549.10.camel@localhost>
Content-Type: text/plain
Message-Id: <1074107842.1153.959.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 14 Jan 2004 14:17:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 14:11, Daniel Gryniewicz wrote:

> I have an athlon-xp laptop (HP pavilion ze4500) with powernow that
> definitely goes into low power mode when the plug is pulled.  The screen
> goes dark, and everything slows down.

Dave did not mean that the other power management schemes cannot do the
automatic reduction on loss of AC, just that there is no SMM/BIOS hacks
to do it automatically.

Your APM scripts are probably adjusting your CPU speed when you go on
AC.  Fedora does this, for example.

That is cool - the OS (user-space, even) controls the policy.

What we don't like is how SpeedStep can be controlled from SMM.

	Robert Love


