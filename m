Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271302AbTHHHK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 03:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271307AbTHHHK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 03:10:28 -0400
Received: from 165.Red-217-126-36.pooles.rima-tde.net ([217.126.36.165]:10472
	"EHLO pau.newtral.org") by vger.kernel.org with ESMTP
	id S271302AbTHHHK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 03:10:26 -0400
Date: Fri, 8 Aug 2003 09:10:19 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Cc: Peter Svensson <petersv@psv.nu>
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
In-Reply-To: <Pine.LNX.4.44.0308080850280.1466-100000@cheetah.psv.nu>
Message-ID: <Pine.LNX.4.44.0308080908030.3461-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Peter Svensson wrote:

> I have had rpm lock up on me a few times. I think it was waiting on a 
> sempahore or some other synchronization event. After killing the process 
> (after several hours) no rpm transactions could be completed, they all 
> hanged at the same point. The only way to get rpm to work again was to 
> reboot the system. 
> 
> Not sure if it is related or not though. I never thought to try it as 
> non-root.

There are some temporary files locking the normal operation.
$ rm /usr/lib/rpm/__*db*
will do the trick.

Pau

