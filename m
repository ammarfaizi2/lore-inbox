Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUHOLgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUHOLgk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 07:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUHOLgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 07:36:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:16273 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266595AbUHOLgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 07:36:39 -0400
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David N. Welton" <davidw@dedasys.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <873c2ohjrv.fsf@dedasys.com>
References: <873c2ohjrv.fsf@dedasys.com>
Content-Type: text/plain
Message-Id: <1092569364.9539.16.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 21:29:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 18:45, David N. Welton wrote:

> but it's not the same problem... I removed the ohci_hcd module from
> the kernel (it's present at boot), and sleep still doesn't happen.  I
> don't even get the "breathing" light, and yet the computer still seems
> warm after some time, seemingly indicative that it's not really asleep
> or dead.  I can only restart it via the Ctrl-Command-Power
> combination.

Best thing at this point is to hack out the sleep code in the
video driver to see where it dies during the sleep process...

Ben.


