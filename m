Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTETAtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTETAtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:49:17 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:10915 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262706AbTETAtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:49:16 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 19 May 2003 17:58:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Comparing the aio and epoll event frameworks.
In-Reply-To: <3EC98373.40503@kegel.com>
Message-ID: <Pine.LNX.4.55.0305191757150.6565@bigblue.dev.mcafeelabs.com>
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net>
 <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com>
 <3EC9807D.3080804@kegel.com> <Pine.LNX.4.55.0305191743230.6565@bigblue.dev.mcafeelabs.com>
 <3EC98373.40503@kegel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Dan Kegel wrote:

> > For single shot I mean that once you receive one event, you will not
> > receive more events for that fd if you do not rearm it. Suppose you
> > receive 1000 bytes of data and you get an event (EPOLLIN). If after 10
> > seconds you receive another 1000 bytes, you will receive another event.
> > This is not single shot.
>
> Oh, ok.  I much prefer plain old edge triggered, anyway.  It does
> the right thing with less fuss.

If someone will show a practical case where you cannot live without,
implementing it is trivial.



- Davide

