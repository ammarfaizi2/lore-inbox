Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbTLCQy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTLCQyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:54:55 -0500
Received: from email-out2.iomega.com ([147.178.1.83]:64977 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265084AbTLCQyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:54:47 -0500
Subject: bootable lk 2.5 defconfig which
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1070470431.2347.0.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Dec 2003 09:53:52 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2003 16:54:46.0733 (UTC) FILETIME=[284967D0:01C3B9BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody have a list of which lk 2.5 defconfig commonly do boot?

Or indeed the subset of that list that support loop.ko?  And X-Windows?

So far here I have only found that 2.5.56 boots clean.  2.5.26 gives me
results without gui.  2.5.47 does not loop.  2.5.37 2.5.41 2.5.51 do not
boot.  2.5.1 and 2.5.15 have no defconfig.

Seemingly irrelevant Google searches include:

http://groups.google.com/groups?q=2.5+bootable+BUG-HUNTING
http://groups.google.com/groups?q=2.5+BUG-HUNTING
http://groups.google.com/groups?q=2.5+"BUG-HUNTING"

Pat LaVarre

P.S. I ask because of:

> From: http://lxr.linux.no/source/Documentation/BUG-HUNTING
> ...
> My apologies to Linus and the other kernel hackers
> for describing this brute force approach, it's
> hardly what a kernel hacker would do.  However, it
> does work and it lets non-hackers help fix bugs.

which I reach by way of:

> From: http://marc.theaimsgroup.com/?t=107032382400001
> Subject: Re: diff "lk 2.4 udf.ko" "lk 2.6 udf.ko"
> ...
> 2.4.23 ok
> 2.5.1 no defconfig
> 2.5.15 no defconfig
> 2.5.26 no gui
> 2.5.37 does not boot
> [2.5.41 does not boot (init kill)]
> 2.5.47 does not loop and complains much of hdc
> 2.5.51 does not boot
> 2.5.56 fails
> 2.6.0-test11 fails


