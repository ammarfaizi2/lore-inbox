Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTFJGca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 02:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTFJGc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 02:32:29 -0400
Received: from granite.he.net ([216.218.226.66]:7435 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262386AbTFJGc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 02:32:29 -0400
Date: Mon, 9 Jun 2003 23:48:29 -0700
From: Greg KH <greg@kroah.com>
To: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-ID: <20030610064829.GA2370@kroah.com>
References: <20030610061654.GB25390@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610061654.GB25390@himi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 04:16:54PM +1000, Simon Fowler wrote:
> I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> tested is bk as of 2003-06-04). lspci lists this hardware:

Hm, mine boots, but my kernel locks up when accessing /dev/rtc in the
init scripts (through hwclock.)  2.5.69 works, 2.5.70 doesn't.  I
haven't spent the time to search out the offending problem yet...

greg k-h
