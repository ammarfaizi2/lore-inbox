Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135685AbREFNqX>; Sun, 6 May 2001 09:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135686AbREFNqO>; Sun, 6 May 2001 09:46:14 -0400
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:44776 "EHLO
	smtprelay2.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S135685AbREFNqB>; Sun, 6 May 2001 09:46:01 -0400
Message-ID: <3AF57F72.A075ADBC@adelphia.net>
Date: Sun, 06 May 2001 09:44:34 -0700
From: Stephen Wille Padnos <stephenwp@adelphia.net>
Organization: Thoth Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Interrupting select
In-Reply-To: <200105022344.f42NiZ727894@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
[snip]> um, shouldn't you be testing for res==-1, as well?

> > specifically that condition and errno==EINTR is how I'd expect
> > signals to effect the loop...

[snip]

> I assumed that "error" is something like trying to  watch for a
> negative number or zero descriptors, or having a fd_set that doesn't
> contain open fd's. The reason I assumed that is because EINTR is not
> listed as a possible:
>
>
> ERRORS
>        EBADF   An invalid file descriptor was given in one of the
>                sets.
>        EINTR   A non blocked signal was caught.

umm ^^^^^^ - it looks like it's listed here :)

>        EINVAL  n is negative.
>        ENOMEM  select was unable to allocate memory for  internal
>                tables.

