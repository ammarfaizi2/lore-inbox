Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbTLKRTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbTLKRTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:19:15 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:50122 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S265196AbTLKRTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:19:12 -0500
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups
	patch, no difference)
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031211163825.GA1413@forming>
References: <1071159379.1331.4.camel@slappy> <20031211163825.GA1413@forming>
Content-Type: text/plain
Message-Id: <1071163143.1345.12.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 12:19:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-11 at 11:38, Josh McKinney wrote:
> Do you see hard locks with APIC/IO-APIC enabled?  Do you see this oops
> with APIC/IO-APIC enabled?  Just curious because I can reproduce the
> hard locks eventually, but never get an oops.  Also, what patches are
> you running and what kernel version?

With apic/io-apic enabled it crashes hard during boot (with oopses, as I
recall).  I haven't tested apic support with the fixup patches.

The kernel is 2.4.23 plus the patches from "Fixes for nforce2 hard
lockup, apic, io-apic, udma133 covered"
(http://marc.theaimsgroup.com/?l=linux-kernel&m=107080280512734&w=2) and
athcool was running. (Its currently disabled, to see if that might have
something to do with it.)  The machine hasn't been rebooted since the
oops, since it seems to be limping along.  (I did find some minorly
corrupted data earlier; libbz2 had to be reinstalled.  Once its
straightened out I'll run debsums against it and fix up anything that
got mangled..)

The same oops was occurring in stock 2.4.22.

-- 
Disconnect <lkml@sigkill.net>

