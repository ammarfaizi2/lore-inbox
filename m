Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbTGUHjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 03:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269333AbTGUHjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 03:39:16 -0400
Received: from mail2.uu.nl ([131.211.16.76]:7656 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S269325AbTGUHjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:39:15 -0400
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: video4linux-list@redhat.com
Cc: Greg KH <greg@kroah.com>, Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030721072853.GA21450@bytesex.org>
References: <20030716084448.GC27600@bytesex.org>
	 <20030716161924.GA7406@kroah.com> <20030716202018.GC26510@bytesex.org>
	 <20030716210800.GE2279@kroah.com> <20030717120121.GA15061@bytesex.org>
	 <20030717145749.GA5067@kroah.com> <20030717163715.GA19258@bytesex.org>
	 <20030717214907.GA3255@kroah.com> <20030718095920.GA32558@bytesex.org>
	 <20030718234359.GK1583@kroah.com>  <20030721072853.GA21450@bytesex.org>
Content-Type: text/plain
Message-Id: <1058772757.2256.207.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 21 Jul 2003 09:55:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On Mon, 2003-07-21 at 09:28, Gerd Knorr wrote:
> Breaking the build _right now_ with 2.6 becoming stable is IMHO not a
> good idea, I think I better try to avoid that until 2.7.

The build is broken for quite some v4l drivers already (zr36120,
zr36067, the mpeg card, afaik), and really, the ones not in the kernel
will not officially "support" 2.6.x anyway before it's stable. It
shouldn't be that much work. I'd suggest to try to get it in before
2.6.0. This whole "we'll now turn number 5->6 and everything will be
stable" is there to help developers in releasing a new stable version,
not to prevent them from innovating and improving. I mean, this won't
actually be a totally new subsystem like the VM that needs to be
debugged in the next few months just after we've release 2.6.0, right?
It's just a small move. Fixing the drivers shouldn't be hard, and if
we/you ("we" as in the v4l driver developers) synchronize that nicely
with each other, there shouldn't be an actual problem.

(Related, I [finally] got 2.6.0-test1 to work so a new patch for my
driver is coming up in one of the next few days; please, someone kick it
forward to Linus then).

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

