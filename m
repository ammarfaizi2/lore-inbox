Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265807AbUGHGIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbUGHGIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUGHGIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:08:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:61617 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265807AbUGHGIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:08:24 -0400
Date: Wed, 7 Jul 2004 23:07:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: wli@holomorphy.com, ltp-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, testdev@osdl.org
Subject: Re: [LTP] Re: Recent changes in LTP test results
Message-Id: <20040707230715.7a25c95c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0407071334460.22452-100000@osdlab.pdx.osdl.net>
References: <20040706191009.279aed14.akpm@osdl.org>
	<Pine.LNX.4.33.0407071334460.22452-100000@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryce Harrington <bryce@osdl.org> wrote:
>
> I have retested with ltp-full-20040603.  This version of LTP hangs on
>  our system but fortunately completes most of the tests before doing so.
>  It indicates that it still encounters the same errors, e.g.:
> 
>  access03       1   FAIL : access((char *)-1,R_OK) failed with errno 2 : No such file or directory but expected 14 (EFAULT)
>  access03       2   FAIL : access((char *)-1,W_OK) failed with errno 2 : No such file or directory but expected 14 (EFAULT)

Nope, sorry, still cannot reproduce it - you'll need to debug it at your end.

BTW, how long does a runalltests run take nowadays?  More than 90 minutes,
that's for sure.  That's quite irritating...
