Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUJRHvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUJRHvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 03:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUJRHvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 03:51:20 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63692 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S264246AbUJRHvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 03:51:19 -0400
Subject: Re: [BUG] JVM crashes with 2.6.9-rc2
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: roland@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1097968058.8033.8.camel@localhost>
References: <1097928466.13431.8.camel@localhost>
	 <20041016124519.627456de.akpm@osdl.org> <1097968058.8033.8.camel@localhost>
Date: Mon, 18 Oct 2004 10:51:34 +0300
Message-Id: <1098085894.13099.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2004-10-16 at 12:45 -0700, Andrew Morton wrote:
> > That's peculiar.  Are you sure about that?

On Sun, 2004-10-17 at 02:07 +0300, Pekka Enberg wrote:
> I tested again and I now get the crash with _all_ of the above kernels
> so it's definitely not the patch.  Sorry about that.  I'll run memtest86
> tomorrow to see if my hardware is broken.

Sorry, this is probably not a kernel bug.

My test case was slightly different for the first and second run which
is why I got varying results.  I can reproduce the crash now with _all_
recent 2.6 kernels so the bug is likely somewhere else.  The JVM crashes
at different locations depending on the kernel version which is why I
thought the problem was in the kernel in the first place.

Thanks a lot for the help and sorry for the noise.

		Pekka

