Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbSLDCBH>; Tue, 3 Dec 2002 21:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbSLDCBH>; Tue, 3 Dec 2002 21:01:07 -0500
Received: from transfire.txc.com ([208.5.237.254]:34021 "EHLO pguin2.txc.com")
	by vger.kernel.org with ESMTP id <S266805AbSLDCBG>;
	Tue, 3 Dec 2002 21:01:06 -0500
Date: Tue, 3 Dec 2002 21:08:38 -0500
From: Igor Schein <igor@txc.com>
To: linux-kernel@vger.kernel.org
Subject: performance of cache-intensive applications
Message-ID: <20021204020838.GF3807@txc.com>
Reply-To: igor@txc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using an open-source application on ix86 to perform a task which
is cache-intensive.  When I run consecutive iterations of the task on
a fixed input, the variance in timing of each iteration is extemely
high.   Needless to say, the test machine is always non-occupied.

On every other OS I tried, Solaris, HPUX, FreeBSD and Tru64, the
timing is very consistent between the iterations.  My question is, are
there known issues with L2 cache reuse in Linux kernel?

I can provide any necessary information for anyone interested in
addressing this issue, but I purposely skipped most technical details
in this post to keep it simple.

Thanks in advance.

Igor

