Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUFZVPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUFZVPF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 17:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbUFZVPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 17:15:05 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:14940 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266435AbUFZVOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 17:14:52 -0400
Message-ID: <40DDE74A.3090301@sbcglobal.net>
Date: Sat, 26 Jun 2004 16:14:50 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6) Gecko/20040419
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Pauli Virtanen <pauli.virtanen@hut.fi>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <40DC38D0.9070905@kolivas.org> <40DDD6CC.7000201@sbcglobal.net> <200406262211.24373.mbuesch@freenet.de>
In-Reply-To: <200406262211.24373.mbuesch@freenet.de>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Buesch wrote:

> On Saturday 26 June 2004 22:04, you wrote:
>
> >Hi Con,
>
> >I don't know what's going on but 2.6.7-mm2 with the staircase v7.4 (with
> >or without staircase7.4-1) takes about 3 hours to get from loading the
> >kernel from grub to the login prompt.  Now I realize my K6-2 400 isn't
> >state of the art...  I don't have this problem running 2.6.7-mm2.
>
> >It just pauses after starting nearly every service for an extended
> >period of time.  It responds to sys-rq keys but just seems to be doing
> >nothing while waiting.
>
> >Any suggestions?
>
>
> Maybe same problem as mine?
> Some init-scripts don't get their timeslices?

I was wondering if not.  I didn't notice any problems while using it 
once it had booted, but then I didn't really try to stress it much 
either.  I'm running gentoo and have RC_PARALLEL_STARTUP="yes" set in my 
/etc/conf.d/rc, maybe that's what makes me hit this during init whereas 
I haven't seen anyone else mention this.

>
> >Thanks,
>
> >Wes Janzen
>
>
> (Oh, please don't quote whole patches in future, if you don't
> comment on them, Wes. Thanks.)
>
Sorry, I always forget that mozilla responds with the attachment.


