Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317965AbSGLBYN>; Thu, 11 Jul 2002 21:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317966AbSGLBYM>; Thu, 11 Jul 2002 21:24:12 -0400
Received: from [209.237.59.50] ([209.237.59.50]:56992 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317965AbSGLBYK>; Thu, 11 Jul 2002 21:24:10 -0400
To: george anzinger <george@mvista.com>
Cc: Stevie O <oliver@klozoff.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <Pine.LNX.4.10.10207110847170.6183-100000@zeus.compusonic.fi>
	<5.1.0.14.2.20020711201602.022387b0@whisper.qrpff.net>
	<3D2E2C48.DCB509D7@mvista.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 11 Jul 2002 18:26:52 -0700
In-Reply-To: <3D2E2C48.DCB509D7@mvista.com>
Message-ID: <52adoxrb1f.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "george" == george anzinger <george@mvista.com> writes:

    george> Well, in truth it has nothing to do with interrupts.  It
    george> is just that that is the way most systems keep time.  The
    george> REAL definition of HZ is in its relationship to jiffies
    george> and seconds.

    george> I.e. jiffies * HZ = seconds, by definition.

I'm sure you know the truth, but this isn't quite right.  Just to be
pedantic and make sure the correct definition is out there:

  jiffies / HZ = seconds

For example if HZ is 100 then the jiffy counter is incremented 100
times each second.

Best,
  Roland
