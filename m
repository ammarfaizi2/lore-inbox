Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbULAW3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbULAW3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULAW3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:29:21 -0500
Received: from alog0449.analogic.com ([208.224.222.225]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261469AbULAW3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:29:15 -0500
Date: Wed, 1 Dec 2004 17:29:13 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: keyboard timeout
Message-ID: <Pine.LNX.4.61.0412011721090.8835@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If Linux 2.6.9 is booted on a 40 MHz `486 with the standard
ISA clock of 14.3 MHz (yes that's the standard), the kernel
will complain about a keyboard timeout for every key touched!

Somebody apparently didn't test their changes sometime in
the past I've seen this also on 2.4.26, but not so often.

Will somebody please double the time-out or tell me where
to fix it! The timeout was only supposed to handle the
fact that a keyboard could get (or be) disconnected. It
can be a long timeout without ever affecting ordinary
use.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
