Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270605AbTGURI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTGURI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:08:58 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38153
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270605AbTGURIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:08:55 -0400
Date: Mon, 21 Jul 2003 10:23:55 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] O7int for interactivity
Message-ID: <20030721172355.GA1158@matchmail.com>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
	Davide Libenzi <davidel@xmailserver.org>
References: <20030718230717.GG2289@matchmail.com> <200307190930.37447.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307190930.37447.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 09:30:37AM +1000, Con Kolivas wrote:
> On Sat, 19 Jul 2003 09:07, Mike Fedyk wrote:
> > On Sat, Jul 19, 2003 at 02:10:49AM +1000, Con Kolivas wrote:
> > > Here is an update to my Oint patches for 2.5/6 interactivity. Note I will
> > Is this on top of 06 or 06.1?
> 
> On top of O6.1.
> 

Ok, after some testing I have a test case that hits a severe starvation case.

I have the courier-imap server running on my box, and when mozilla gets
messages with junk filtering turned on, it has to download each message to
scan it, almost all of the processing is in mozilla, and the mouse is smooth
as you'd see on windows, but I can't get anything else to run.

My kde taskbar won't switch desktops, though gkrellm keeps running smoothly
reporting 100% processor usage.

I'm not using sound on this machine ATM, so I have nothing to say about
XMMS...
