Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUH2XK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUH2XK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUH2XK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:10:58 -0400
Received: from ruby.getonit.net.au ([210.8.120.221]:21907 "EHLO
	ruby.getonit.net.au") by vger.kernel.org with ESMTP id S268355AbUH2XKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:10:41 -0400
From: "Tim Warnock" <timoid@getonit.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: RE: More than 2048 ptys on 2.4.27
Date: Mon, 30 Aug 2004 09:10:34 +1000
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA4+E3P43380+sBshf1RHa98KAAAAQAAAADqFMzKrGHECigO+5JIV4KgEAAAAA@getonit.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA4+E3P43380+sBshf1RHa98KAAAAQAAAAQtYYqknGzU6+CzMBqc9FPgEAAAAA@getonit.net.au>
Thread-Index: AcSMjQsUtaA0ilozQAO1tkwqpMgdZABkETnw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Tim Warnock
> Sent: Saturday, 28 August 2004 9:25 AM
> To: linux-kernel@vger.kernel.org
> Subject: More than 2048 ptys on 2.4.27
> 
> Hi all,
> Im trying to increase ptys from 2048 to 4096 by doing these things:
> 
> Modifying include/linux/major.h:
> Increase major numbers to 16
> Move slave major start to 231 (according to docs this is 
> available for use)
> 
> This appears to work to the point that the kernel doesn't 
> panic on boot (ive
> had some fun before now ;) however when an application tries 
> to allocate a
> pty I get an: "inappropriate ioctl for device"
> 
> As a test I lowered major numbers to 4, set ptys to 1024 and 
> put slave major
> start to 138 (should have been 136) and I didn't get this error.
> 
> So my question is how do I allow the use of major numbers 231 
> through to 247
> as pty slaves and major numbers 136-144 as pty masters?

I was wondering if no-one can help specifically whether they could at least
point me in the direction I'd need to go to learn how this works.

Thanks for any assistance, its appreciated.

Tim

