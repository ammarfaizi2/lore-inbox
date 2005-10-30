Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVJ3TFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVJ3TFm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVJ3TFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:05:42 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:22686 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932220AbVJ3TFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:05:41 -0500
Date: Sun, 30 Oct 2005 20:05:38 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: ray@madrabbit.org
Cc: linux-kernel@vger.kernel.org, ray-lk@madrabbit.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051030190538.GA25940@uio.no>
References: <20051030023557.GA7798@uio.no> <2c0942db0510301054j64e650efqe416e14fc1e3bff2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c0942db0510301054j64e650efqe416e14fc1e3bff2@mail.gmail.com>
X-Operating-System: Linux 2.6.14-rc5 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.8 (--)
X-Spam-Report: Status=No hits=-2.8 required=5.0 tests=ALL_TRUSTED version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 11:54:37AM -0700, Ray Lee wrote:
> It seems a not unreasonable assumption that 2.6.13 works okay, or
> there would have been reports of unhappiness (though that is a pure
> assumption). Since it only takes a few hours to get the problem to
> occur, is it feasible to try to bisect the problem space by testing
> some snapshots between 2.6.13 and 2.6.14?

Unfortunately, the machine does quite a bit of other work apart from BIND, so
unless somebody can reproduce this on another machine, it will be a bit
difficult.

I have a run going in valgrind now to see if it can find anything bad about
the pointers in the msg_hdr structure (the structure itself appears to be OK,
judging from my printf-debugging); it's been going for a few hours, so I hope
it will be entering its zombie mode now soon :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
