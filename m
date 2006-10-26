Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752133AbWJZJTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbWJZJTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWJZJTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:19:10 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:31414 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1752133AbWJZJTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:19:09 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
In-Reply-To: <20061026085700.GI8394166@melbourne.sgi.com>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <200610251432.41958.rjw@sisk.pl>
	 <1161782620.3638.0.camel@nigel.suspend2.net>
	 <200610252105.56862.rjw@sisk.pl>
	 <20061026073022.GG8394166@melbourne.sgi.com>
	 <1161850709.17293.23.camel@nigel.suspend2.net>
	 <20061026085700.GI8394166@melbourne.sgi.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 19:18:57 +1000
Message-Id: <1161854338.17293.25.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2006-10-26 at 18:57 +1000, David Chinner wrote:
> I didn't think we've ever done that - periodic or delayed operations
> are passed off to the kernel threads to execute. A stack trace
> (if you still have it) would be really help here.

I don't, but I know how to get it again. Will give it a go shortly.

> Hmmm - we have a couple of per-cpu work queues as well that are
> used on I/O completion and that can, in some circumstances,
> trigger new transactions. If we are only flush metadata, then
> I don't think that any more I/o will be issued, but I could be
> wrong (maze of twisty passages).

I can understand that. I'm trying to learn Xgl programming at the mo :)

Nigel

