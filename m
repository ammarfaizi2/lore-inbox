Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTHaOAo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbTHaOAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:00:44 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:9926 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S261896AbTHaOAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:00:43 -0400
Date: Sun, 31 Aug 2003 07:00:37 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dan Kegel <dank@kegel.com>
Cc: GCC Mailing List <gcc@gcc.gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: LMbench as gcc performance regression test?
Message-ID: <20030831140037.GA16620@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dan Kegel <dank@kegel.com>, GCC Mailing List <gcc@gcc.gnu.org>,
	linux-kernel@vger.kernel.org
References: <3F51A201.8090108@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F51A201.8090108@kegel.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 12:21:37AM -0700, Dan Kegel wrote:
> (There seems to be large variations in successive runs of LMBench
> when I try it, so it may take me a bit of work to get repeatable
> results.)

Other than the context switch part or anything based on it, that shouldn't
be true, it should be very stable.

I'm pretty convinced that the variations are due to different pages being
allocated and the result cache contention makes things bounce.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
