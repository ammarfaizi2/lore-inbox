Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUANGVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 01:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUANGVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 01:21:24 -0500
Received: from ozlabs.org ([203.10.76.45]:15288 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262015AbUANGVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 01:21:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16388.28153.476037.234076@cargo.ozlabs.ibm.com>
Date: Wed, 14 Jan 2004 09:15:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [2/3]
In-Reply-To: <20040113173352.D7256@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>
	<20040113113650.A2975@flint.arm.linux.org.uk>
	<20040113114948.B2975@flint.arm.linux.org.uk>
	<20040113171544.B7256@flint.arm.linux.org.uk>
	<20040113173352.D7256@flint.arm.linux.org.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> Here are patches to drivers in the 2.6 kernel which have not been tested
> to correct the tiocmset/tiocmget problem.

Note that drivers/macintosh/macserial.c is now deprecated, people
should use drivers/serial/pmac_zilog.c.

Ben, is it time to get rid of macserial.c yet?

Paul.
