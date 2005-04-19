Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVDSIcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVDSIcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDSIcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:32:22 -0400
Received: from mail02.osl.basefarm.net ([81.93.160.49]:44249 "EHLO
	mail02.osl.basefarm.net") by vger.kernel.org with ESMTP
	id S261195AbVDSIcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:32:18 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Igor Shmukler <igor.shmukler@gmail.com>, Rik van Riel <riel@redhat.com>,
       Daniel Souza <thehazard@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
References: <6533c1c905041511041b846967@mail.gmail.com>
	<1113588694.6694.75.camel@laptopd505.fenrus.org>
	<6533c1c905041512411ec2a8db@mail.gmail.com>
	<e1e1d5f40504151251617def40@mail.gmail.com>
	<6533c1c905041512594bb7abb4@mail.gmail.com>
	<Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
	<6533c1c905041807487a872025@mail.gmail.com>
	<1113836378.6274.69.camel@laptopd505.fenrus.org>
	<6533c1c9050418080639e41fb@mail.gmail.com>
	<1113837657.6274.74.camel@laptopd505.fenrus.org>
	<wvhis2jewxh.fsf@cornavin.basefarm.no>
	<1113853203.6274.97.camel@laptopd505.fenrus.org>
From: Terje Malmedal <tm@basefarm.com>
Date: Tue, 19 Apr 2005 10:32:09 +0200
In-Reply-To: <1113853203.6274.97.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Mon, 18 Apr 2005 21:40:02 +0200")
Message-ID: <wvh8y3fdv5i.fsf@cornavin.basefarm.no>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Scan-Result: No virus found in message 1DNo9Z-0005bO-8t.
X-Scan-Signature: mail02.osl.basefarm.net 1DNo9Z-0005bO-8t d1176c3bd7729e79b15e81108859fa67
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Arjan van de Ven]
>> What do I do the next time I need to do something like this? 

> use kprobes or so to actually replace the faulty lower level function..
> you don't know from how many different angles the lower level function
> is called, so you're really best of by replacing it at the lowest
> possible level, eg closest to the bug. That *very* seldomly is the
> actual syscall function.

This is exactly what I want to do, but how do I do the replacing part?

I understand how I create pre_ and post_handlers with kprobes, but not
how I can stop a function from being executed.

-- 
 - Terje
tm@basefarm.no
