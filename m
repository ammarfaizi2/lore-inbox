Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317549AbSFEF0O>; Wed, 5 Jun 2002 01:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSFEF0N>; Wed, 5 Jun 2002 01:26:13 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:10252 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S317549AbSFEF0M>; Wed, 5 Jun 2002 01:26:12 -0400
Message-ID: <3CFD1C1E.91D47760@opersys.com>
Date: Tue, 04 Jun 2002 15:59:26 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <3CFB2A38.60242CBA@opersys.com> <20020604161001.K36@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Pavel,

Pavel Machek wrote:
> > We have released the initial implementation of the Adeos nanokernel.
> > The following is a complete description of its background, its
> > implementation, its API, and its potential uses. Please also see the
> > press release (http://www.freesoftware.fsf.org/adeos/pr-2002-06-03.en.txt)
> > and the project's workspace (http://freesoftware.fsf.org/projects/adeos/).
> > The Adeos code is distributed under the GNU GPL.
> 
> Sounds interesting...

Thanks.

> Also, unlike UML, kernels are not protected from each other.

True, if they do physical accesses in each other's areas there's a problem.
But we're assuming 2 things here:
1) You are using stable kernels.
2) See the next answer.

> So if your FreeBSD+Linux combination crashes, you do not know if Linux or
> FreeBSD caused it.

No one said that you can't have an early domain in the pipeline that
specifically deals with this

> This is same approach rtLinux takes, right?

No, Have you seen the explanation I provided earlier to Erik:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102309926620900&w=2

Adeos is clearly different from anything that is part of the rtlinux patent.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
