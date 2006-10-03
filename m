Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030618AbWJCWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030618AbWJCWuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWJCWuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:50:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030618AbWJCWuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:50:02 -0400
Date: Tue, 3 Oct 2006 15:49:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>, Pavel Emelianov <xemul@openvz.org>,
       Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] IPC namespace core
Message-Id: <20061003154947.7ef2d4a3.akpm@osdl.org>
In-Reply-To: <1159912891.27726.3.camel@pmac.infradead.org>
References: <200610021601.k92G13mT003934@hera.kernel.org>
	<1159866174.3438.66.camel@pmac.infradead.org>
	<20061003093505.0bb7bb6a.akpm@osdl.org>
	<1159912891.27726.3.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 23:01:31 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Tue, 2006-10-03 at 09:35 -0700, Andrew Morton wrote:
> > We'll get there ;) I'm waiting for a suitable time to merge
> > add-config_headers_check-option-to-automatically-run-make-headers_check.patch,
> > which will cause all `make allmodconfig' testers to automatically run `make
> > headers_check'.
> > 
> > But I don't think the time is right yet - a little later, when things have
> > settled down and when it all works nicely on multiple architectures.
> 
> Other than the glitches I just whinged about, it _does_ work nicely on
> almost all architectures. I sent Linus those fixes as soon as 2.6.18
> came out, and you were talking about putting them in -stable too
> (although you went quiet on that front when you saw how many there
> were__).
> 
> In fact, I held off on merging some of Arnd's extra checks because I
> didn't want to add extra failures -- specifically because I thought we
> were turning that config-headers-check thingy on.
> 

Yes - I'll send it along soon.  I just want to have a few hours to convince
myself that it won't break the whole world if I do...
