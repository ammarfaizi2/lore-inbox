Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSIAOwm>; Sun, 1 Sep 2002 10:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSIAOwm>; Sun, 1 Sep 2002 10:52:42 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:9994 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317102AbSIAOwl>; Sun, 1 Sep 2002 10:52:41 -0400
Date: Sun, 1 Sep 2002 16:56:59 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] warnkill trivia 2/2
Message-ID: <20020901145658.GD7325@louise.pinerecords.com>
References: <200209011452.QAA17260@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209011452.QAA17260@harpo.it.uu.se>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 7 days, 4:02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >i.e. it's impossible to have a constant
> >pointer to a non-constant value w/o using a qualified
> >typedef.
> 
> void g(int * const t) { *t = 0; }
>
>
> >W/o a typedef, gcc seems unable to tell the difference
> >between 'const int *' and 'int const *' altogether.
> 
> There is no difference. Read the C spec, or Harbison&Steele
> which has had an explanation of 'const' since their '87 2nd Ed.


Ok, that explains it, obviously I (and DaveM :D) didn't know the syntax.
Thanks for the reference!

I'm going to redo the patches.

T.
