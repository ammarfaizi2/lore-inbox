Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUAQCMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUAQCMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:12:55 -0500
Received: from mta16.srv.hcvlny.cv.net ([167.206.5.110]:13868 "EHLO
	mta16.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265951AbUAQCMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:12:53 -0500
Date: Fri, 16 Jan 2004 21:12:52 -0500
From: Brett Gmoser <aftli@optonline.net>
Subject: Re: [linuxkernel] Re: Raw I/O Problems with inb()
In-reply-to: <pan.2004.01.16.17.41.22.932043@smurf.noris.de>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <20040116211252.6581fb0f.aftli@optonline.net>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040115215243.39fcb0fd.aftli@optonline.net>
 <pan.2004.01.16.11.27.43.359172@smurf.noris.de>
 <6.0.1.1.0.20040116094624.00acea40@optonline.net>
 <pan.2004.01.16.17.41.22.932043@smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks very much for your insight.  I do appreciate it.

I do agree that the next step will be to write a kernel module.  However, I would like to see if it is feasible to do this with inb(), since I see no very easy way around the fact that I do not want the program to work remotely.

Really, the question boils down to this: Is the keyboard status port on AMD systems 0x64, or is it something else?  If so, what is it?

Thank you!

Brett

On Fri, 16 Jan 2004 18:41:25 +0100
Matthias Urlichs <smurf@smurf.noris.de> wrote:

> Well, as I said, I would solve the "how" problem with a kernel module
> which monitors mouse movement or keyboard events. This happens to be a
> whole lot more reliable, and it will also eat no CPU time when nothing's
> happening.
> 
> Plus, it will work on any mouse or keyboard. People actually _use_ USB
> critters these days, you know ...
> 
