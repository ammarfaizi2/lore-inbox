Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUBQXfM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUBQXfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:35:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:59299 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266626AbUBQXfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:35:04 -0500
Subject: Re: Linux 2.6.3-rc4 Massive strange corruption with new radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Charles Johnston <cjohnston@networld.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40329B57.9060901@networld.com>
References: <403274D2.4020407@networld.com>
	 <1077055997.1076.23.camel@gaston>  <40329B57.9060901@networld.com>
Content-Type: text/plain
Message-Id: <1077060699.1078.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 10:31:39 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, it worked fine with that line commented out.  I can switch vt's, be 
> in X, etc. no problems.

Can you send me the dmesg log still please ?

> The only issue I see is when I do a 'clear' on the vt, it doesn't clear 
> the text, but blanks every nth row of pixels.  Switching vt's and back 
> clears the screen.

Does this happen even without using XFree ? There is a known problem
with clears when switching _from_ XFree... I'm working on a fix.

> There are also a few rows of garbage pixels at the bottom that linger 
> across vt switches.

Yes, same as above afaik


