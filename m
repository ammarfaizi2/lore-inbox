Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRB0NWC>; Tue, 27 Feb 2001 08:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRB0NVw>; Tue, 27 Feb 2001 08:21:52 -0500
Received: from linuxcare.com.au ([203.29.91.49]:44046 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129227AbRB0NVr>; Tue, 27 Feb 2001 08:21:47 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 28 Feb 2001 00:18:00 +1100
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
Message-ID: <20010228001800.C2207@linuxcare.com>
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Feb 27, 2001 at 10:02:11AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> I'm seeing odd behaviour with rsync over ssh between two x86 machines -
> one if the is an UP PIII (Katmai) running 2.4.2 (isdn-gw) and the other
> is an UP Pentium 75-200 (pilt-gw) running 2.2.15pre13 with some custom
> serial driver hacks (for running Amplicon cards with their ISA interrupt-
> sharing scheme).

What version of ssh are you using? Older versions would use blocking IO
which would result in deadlocks (and angry emails wrongly blaming rsync :)

Anton
