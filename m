Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268779AbTBZPP7>; Wed, 26 Feb 2003 10:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268780AbTBZPP7>; Wed, 26 Feb 2003 10:15:59 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:44268 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S268779AbTBZPP6>; Wed, 26 Feb 2003 10:15:58 -0500
Subject: Re: [PATCH] 2.5.63-current replace its with it's where appropriate.
From: Steven Cole <elenstev@mesatop.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200302261200.h1QC0gs23846@Port.imtp.ilyichevsk.odessa.ua>
References: <1046227493.7527.272.camel@spc1.mesatop.com> 
	<200302261200.h1QC0gs23846@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 26 Feb 2003 08:22:21 -0700
Message-Id: <1046272941.6616.194.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 04:57, Denis Vlasenko wrote:
> On 26 February 2003 04:44, Steven Cole wrote:
> > This patch replaces its (possessive of it) with it's (it is)
> > in the following cases where "it is" is meant.
> >
> > its a   -> it's a
> > its an  -> it's an
> > its not -> it's not
> 
> I'd say it's ok to fix misspellings but this apostrophe
> chasing is a bit too much. What comes next? Patches to fix
> violations of "two spaces after the dot" rule?

Nope, no spaces after dots changes.  But, how about
removing unnecessary parenthesis around the expression in the
return statement, e.g.
  
return(-EBUGGYEDITOR); -> return -EBUGGYEDITOR;
 
Just kidding!  I'll leave that for someone more bold or pedantic.

> 
> Single quotes in comments do confuse gcc _and_ some
> text editors with syntax highlighting.
> --
> vda

I've been careful about the single quotes where it affects gcc.
Which brings to mind "affect" (usually a verb, with exceptions) versus
"effect" (usually a noun, with exceptions). ;)

Steven

