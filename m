Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312460AbSCUTSN>; Thu, 21 Mar 2002 14:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSCUTSF>; Thu, 21 Mar 2002 14:18:05 -0500
Received: from zero.tech9.net ([209.61.188.187]:52752 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312460AbSCUTRw>;
	Thu, 21 Mar 2002 14:17:52 -0500
Subject: Re: 2.4.19pre4 preempt: BUG: kunmap while in_interrupt()
From: Robert Love <rml@tech9.net>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203211906.g2LJ6rp04003@athlon.cichlid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 21 Mar 2002 14:17:58 -0500
Message-Id: <1016738278.15337.386.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-21 at 14:06, Andrew Burgess wrote:

> This occured a few minutes of booting, not sure what triggered it but the
> system is somewhat busy. Only happened once and the system seems fine WITHOUT
> a reboot.

Can you run the OOPS through ksymoops (not the evil klogd parser)
please?

If you reboot, does it still occur?  Can you reproduce it without
preempt-kernel?

Also please CC me in the future on preempt-kernel issues to make sure I
don't miss them.

	Robert Love

