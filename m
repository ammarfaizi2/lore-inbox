Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbUKIXtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUKIXtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKIXru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:47:50 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:45210 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261780AbUKIXqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:46:04 -0500
Subject: Re: bk-commits: diff -p?
From: David Woodhouse <dwmw2@infradead.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20041108164302.GA489@work.bitmover.com>
References: <Pine.LNX.4.61.0411080940310.27771@anakin>
	 <20041108164302.GA489@work.bitmover.com>
Content-Type: text/plain
Message-Id: <1100043712.21273.26.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 09 Nov 2004 23:41:52 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 08:43 -0800, Larry McVoy wrote:
> This has been fixed in the following releases:
> 
> bk-3.2.3
> bk-3.2.2c
> bk-3.2.2b
> 
> Correct usage is "bk diffs -up" which will get you unified + procedural diffs.
> -p is currently a hack, it implies -u, but don't depend on that behaviour,
> a future release does this correctly and if you teach your fingers that 
> diffs -p is the same as diffs -up you'll get burned later.

Actually my script is using 'bk export -du -tpatch -r$CSET'. '-dup'
doesn't seem to do the right thing.

-- 
dwmw2


