Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUEPDvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUEPDvT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 23:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUEPDvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 23:51:19 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:13208 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262951AbUEPDvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 23:51:18 -0400
Date: Sat, 15 May 2004 20:48:47 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andreas Schwab <schwab@suse.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       Davide Libenzi <davidel@xmailserver.org>, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040516034847.GA5774@taniwha.stupidest.org>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com> <20040512200305.GA16078@elte.hu> <Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com> <20040512213913.GA16658@fieldses.org> <jevfj1nwe1.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jevfj1nwe1.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 11:55:18PM +0200, Andreas Schwab wrote:

> Signed integer overflow is undefined in C, so the compiler is
> allowed to assume it does not happen.

Really?

Just because something is undefined assuming it never happens is a bit
of a leap of faith IMO.



  --cw
