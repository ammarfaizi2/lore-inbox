Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbTFCQrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbTFCQrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:47:16 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:49161 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265097AbTFCQrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:47:15 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Michael Frank <mflt1@micrologica.com.hk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>
Subject: Re: Linux 2.4.21-rc6
Date: Tue, 3 Jun 2003 18:59:59 +0200
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <Pine.LNX.4.55L.0306031302310.3892@freak.distro.conectiva> <200306040030.27640.mflt1@micrologica.com.hk>
In-Reply-To: <200306040030.27640.mflt1@micrologica.com.hk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306031859.59197.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 18:30, Michael Frank wrote:

Hi Michael,

> > Ok, so you can reproduce the hangs reliably EVEN with -rc6, Marc?
> -rc6 is better - comparable to 2.4.18 in what I have seen with my script.
> After the long obscure problems since 2.4.19x, -rc6 could use serious
> stress-testing.
> User level testing is not sufficient here - it's just like playing
> roulette.
> By serious stress-testing I mean:
> Everone testing comes up with  one dedicated "tough test"
> which _must_ be reproducible (program, script) along his line of
> expertise/application.

well, very easy one:

dd if=/dev/zero of=/home/largefile bs=16384 count=131072

then use your mouse, your apps, switch between them, use them, _w/o_ pauses, 
delay, stops or kinda that. If _that_ will work flawlessly for everyone, then 
it is fixed, if not, it _needs_ to be fixed.

ciao, Marc

