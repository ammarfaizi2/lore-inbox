Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131591AbRCSUqE>; Mon, 19 Mar 2001 15:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131590AbRCSUpz>; Mon, 19 Mar 2001 15:45:55 -0500
Received: from anubis.han.de ([212.63.63.3]:13828 "EHLO anubis.han.de")
	by vger.kernel.org with ESMTP id <S131609AbRCSUps>;
	Mon, 19 Mar 2001 15:45:48 -0500
Date: Mon, 19 Mar 2001 21:48:12 +0100
From: Jens-Uwe Mager <jum@anubis.han.de>
Message-Id: <200103192048.VAA01122@anubis.han.de>
To: linux-kernel@vger.kernel.org
Subject: Re: pselect
In-Reply-To: <mng==UTC200103181732.SAA08924.aeb@vlet.cwi.nl>
In-Reply-To: <mng==UTC200103181732.SAA08924.aeb@vlet.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>For people who prefer programming above documenting,
>here is a simple small thing to do:
>
>POSIX.1g and Austin document a pselect() call intended to
>remove the race condition that is present when one wants
>to wait on either a signal or some file descriptor.
>(See also Stevens, Unix Network Programming, Volume 1, 2nd Ed.,
>1998, p. 168 and the pselect.2 man page released today.)
>Glibc 2.0 has a bad version (wrong number of parameters)
>and glibc 2.1 a better version, but the whole purpose
>of pselect is to avoid the race, and glibc cannot do that,
>one needs kernel support.
>So, probably someone should make a system call pselect
>almost identical to the present select, adding a sigmask
>parameter. (Or something more general.)

Well, pselect is not that interesting I suppose, ppoll would be my
favorite call to make use of.

-- 
Jens-Uwe Mager	<pgp-mailto:62CFDB25>
