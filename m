Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTFUWAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTFUWAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 18:00:11 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:2317 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id S263398AbTFUWAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 18:00:06 -0400
Date: Sat, 21 Jun 2003 16:14:03 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Zack Gilburd <zack@tehunlose.com>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx and SiI3112 problems (2.4.21[-ac1] and 2.5.7x)
Message-ID: <907540000.1056233643@aslan.scsiguy.com>
In-Reply-To: <200306182203.36845.zack@tehunlose.com>
References: <200306182203.36845.zack@tehunlose.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an Adaptec 29160N that uses the aic7xxx driver.  I have had no
> problems with this driver in 2.4.20, but in 2.4.21, my drives fail parity
> checks.  I've gone back and forward between 2.4.20 kernels and 2.4.21
> kernels just to make sure it wasn't the drive's fault.  The exact error
> message(s) are at the middle-end of this email.

The typical reason that you might get a CRC error is that the termination
is not configured correctly on your card.  I don't recall off hand any
particular termination issues for the 29160N that have been resolved
by driver releases after 6.2.8, but newer drivers do have more termination
diagnostics that may help me to resolve your problem.  You should be able
to just drop in the latest driver from here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

If the newer driver still causes problems, let me know and I can give
you instructions on how to enable the debugging I need to better understand
your problem.

--
Justin

