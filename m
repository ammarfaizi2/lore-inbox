Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263587AbTCUL1M>; Fri, 21 Mar 2003 06:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263590AbTCUL1L>; Fri, 21 Mar 2003 06:27:11 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:3563 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S263587AbTCUL1K> convert rfc822-to-8bit; Fri, 21 Mar 2003 06:27:10 -0500
From: Oliver Neukum <oliver@neukum.name>
To: David Brownell <david-b@pacbell.net>
Subject: Re: question on macros in wait.h
Date: Fri, 21 Mar 2003 12:38:02 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <3E7AB696.40204@pacbell.net>
In-Reply-To: <3E7AB696.40204@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303211238.02378.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. März 2003 07:52 schrieb David Brownell:
>   > is there some deeper reason that there's no macro for waiting
>   > uninterruptablely with a timeout? Or did just nobody feel a need
>   > as yet?
>
> Those macros seem to have moved out of <linux/sched.h> (2.4)
> and wait_event_interruptible_timeout() was added about 6
> months ago; the changelog entry says it was for smbfs.
> So I'd guess "no need yet".
>
> Here's an updated version of your patch, now using the same
> calling convention that the other two "can return 'early'"
> calls there provide.  It's behaved in my testing, to replace the
> chaos in the usb synchronous call wrappers.

Much better than my version.

	Regards
		Oliver

