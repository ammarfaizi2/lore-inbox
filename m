Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbTGUORr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbTGUORr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:17:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:12690 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267852AbTGUORr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:17:47 -0400
Date: Mon, 21 Jul 2003 10:28:39 -0400
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile AX8817x driver
Message-ID: <20030721142839.GA9401@kroah.com>
References: <yw1xsmp0f4zh.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xsmp0f4zh.fsf@zaphod.guide>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 02:18:10PM +0200, Måns Rullgård wrote:
> 
> This trivial Makefile patch causes the AX8817x driver to actually be
> built.  The diff is against 2.6.0-test1.

Thanks, I'll go apply this.  Oh, it's only needed if you do not select
any other usb network driver, sorry for missing this before.

greg k-h
