Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129883AbRB0XLf>; Tue, 27 Feb 2001 18:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbRB0XLZ>; Tue, 27 Feb 2001 18:11:25 -0500
Received: from logger.gamma.ru ([194.186.254.23]:16901 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S129883AbRB0XLI>;
	Tue, 27 Feb 2001 18:11:08 -0500
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
Date: 28 Feb 2001 02:01:15 +0300
Organization: Average
Message-ID: <97hbjr$mbp$1@pccross.average.org>
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
X-Comment-To: Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200102271002.f1RA2B408058@brick.arm.linux.org.uk>,
        Russell King <rmk@arm.linux.org.uk> writes:

> I'm seeing odd behaviour with rsync over ssh between two x86 machines -

I've seen hanging rsync over ssh more than once, while sending much data
from an x86 running Linux (late 2.3.x) to Sparc/Solaris2.5.1 over ssh
1.2.26.  I had a feeling that it was triggered by certain data patterns
because it often stopped at the same spot after restart (and therefore
I attributed it to a bug in rsync).  I did not investigate further.

Eugene
