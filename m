Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUBJKTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 05:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUBJKTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 05:19:14 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:19586 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265804AbUBJKTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 05:19:14 -0500
Subject: Re: oops in old isdn4linux and 2.6.2-rc3 (was in -rc2 too)
From: David Woodhouse <dwmw2@infradead.org>
To: Karsten Keil <kkeil@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040210025117.GB17364@pingi3.kke.suse.de>
References: <401E4A80.4050907@web.de>
	 <20040202195139.GB2534@pingi3.kke.suse.de>
	 <1076328820.11882.27.camel@imladris.demon.co.uk>
	 <1076378022.11882.80.camel@imladris.demon.co.uk>
	 <20040210025117.GB17364@pingi3.kke.suse.de>
Content-Type: text/plain
Message-Id: <1076408351.11882.101.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Tue, 10 Feb 2004 10:19:11 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-10 at 03:51 +0100, Karsten Keil wrote:
> Your analyse is correct, but the error is, that
> ll_writewakeup is called with the lock.
> Upper layers should not be called in this path.

That's an evidently sensible answer, yes -- but it looks like it's
always been like this, and fixing it really wasn't not a task I
particularly wanted to undertake at 2am this morning... I think I might
leave that to you :)

-- 
dwmw2


