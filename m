Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUF0K1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUF0K1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 06:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUF0K1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 06:27:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13320 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261711AbUF0K0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 06:26:17 -0400
Date: Sun, 27 Jun 2004 12:16:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 rh9 thrashing unreasonably
Message-ID: <20040627101650.GK29808@alpha.home.local>
References: <40DE3E95.4070702@kegel.com> <200406271134.42853@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406271134.42853@WOLK>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan & Marc,

There was a memory leak in do_fork() which was fixed in 2.4.26-pre-something.
Maybe you can hit it with 200 kernel compiles ! I agree with Marc that you
should try with a non-rh kernel, and more specifically a *recent* kernel.
2.4.20 is quite old, even if there were additional security fixes added to
it. 2.4.27-rc2 is out and doing well, you might want to give it a try ?

Regards,
Willy

