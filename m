Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTBTRGj>; Thu, 20 Feb 2003 12:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTBTRGj>; Thu, 20 Feb 2003 12:06:39 -0500
Received: from havoc.daloft.com ([64.213.145.173]:42645 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266095AbTBTRGi>;
	Thu, 20 Feb 2003 12:06:38 -0500
Date: Thu, 20 Feb 2003 12:16:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Steven French <sfrench@us.ibm.com>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
Subject: Re: cifs leaks memory like crazy in 2.5.61
Message-ID: <20030220171638.GC9800@gtf.org>
References: <OFEBDD7C2C.B0956D07-ON87256CD3.005C9BC9@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFEBDD7C2C.B0956D07-ON87256CD3.005C9BC9@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 10:56:04AM -0600, Steven French wrote:
> I run three file API tests regularly against it - fsx, the connecathon
> "nfs" tests and iozone and use them as a sort of regression test bucket
> (which unfortunately didn't pick this problem up) - as a result of this I
> will add "ls -R" of a deep directory tree to the list (ls -R of a shallow
> tree doesn't seem to show this problem up) - if there are other useful
> filesystem regression cases that I could automate and run, I would love to
> know about them.

Those are more stress tests, than regression tests.  You have to know
what you regressed from, and progressed to, before you have regression
tests.  ;-)

It sounds like unit tests are lacking...

	Jeff



