Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSBHXCe>; Fri, 8 Feb 2002 18:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSBHXCY>; Fri, 8 Feb 2002 18:02:24 -0500
Received: from illiter.at ([63.113.167.61]:31966 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S287816AbSBHXCL>;
	Fri, 8 Feb 2002 18:02:11 -0500
To: wichert@cistron.nl (Wichert Akkerman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide cleanup
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz>
	<3C63C5EF.4050403@evision-ventures.com>
	<20020208133755.A10250@suse.cz>
	<3C63CF54.9090308@evision-ventures.com>
	<a40okb$mds$1@picard.cistron.nl>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 08 Feb 2002 18:00:22 -0500
In-Reply-To: <a40okb$mds$1@picard.cistron.nl>
Message-ID: <nnit97a8ah.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wichert@cistron.nl (Wichert Akkerman) writes:

> In article <3C63CF54.9090308@evision-ventures.com>,
> Martin Dalecki  <dalecki@evision-ventures.com> wrote:
> >The _t at the end of type names is a POSIX habit of markup for system 
> >defined types - this should *NOT* be used in user land programms but is OK for
> >the kernel.
> 
> Why, I don't see that. Everyone should use whatever notation he/she
> feels most comfortable with.

 Err, what?
 Sure mindless programmers can call a function strnew() or strconcat()
if they "feel most comfortable" with that. But it's _wrong_, as that's
a reserved namespace of ISO C. Jut as *_t is a reserved namespace of
POSIX.

 Opengroup seems really slow atm., but hopefully you'll believe one of...

http://sources.redhat.com/ml/libc-alpha/2000-09/msg00185.html
http://www.ioccc.org/1998/data

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
