Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSHTRr7>; Tue, 20 Aug 2002 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSHTRr7>; Tue, 20 Aug 2002 13:47:59 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:7954 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315925AbSHTRr6>; Tue, 20 Aug 2002 13:47:58 -0400
Date: Tue, 20 Aug 2002 19:51:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg Banks <gnb@alphalink.com.au>
cc: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <3D624DB8.1EA1840E@alphalink.com.au>
Message-ID: <Pine.LNX.4.44.0208201930430.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Aug 2002, Greg Banks wrote:

> > I have to manually fix things like CONFIG_ALPHA_NONAME, which is first set
> > by a choice statement and later redefined. My new parser can't deal with
> > this, because user input is given the highest priority.
>
> Well then, there's something we need to look at fixing in the CML1
> corpus.

I considered detecting such cases, but it's too much work for something
that is easy to find and fix manually. The alpha config.in is actually the
only config file I could find that does something like this.

bye, Roman

