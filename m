Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265195AbSJaGSI>; Thu, 31 Oct 2002 01:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSJaGSI>; Thu, 31 Oct 2002 01:18:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36410 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265195AbSJaGSH>; Thu, 31 Oct 2002 01:18:07 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: boissiere@adiglobal.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  October 30, 2002
References: <20021030161708.GA8321@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Oct 2002 23:22:12 -0700
In-Reply-To: <20021030161708.GA8321@suse.de>
Message-ID: <m1iszjgmaz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> Something else I took a look at in the last few days was the ECC
> drivers. These are also zero impact, and could go in after the freeze
> (assuming the authors want them merged). They could do with a small
> amount of cleanup, but otherwise look ok.

Assuming they work.  No offense to the guys who got the ball rolling, but
the architecture is lousy, and every driver I have messed with does not
work correctly, and I wind up reimplementing it before I can use it.

I actually like the idea of ECC drivers, and routinely make certain
there is a working ECC driver on the systems I ship.  It is so much
very easier to catch memory errors with good ECC error reporting.  But
unless I have slept soundly through a fundamental change, the
linux-ecc project currently does not ship quality drivers.  The
infrastructure is bad, and the code is not quite correct. 

If you want I can dig up the drivers I am currently using and send
them to you.

I even have a working memory scrub routine.

Eric
