Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263670AbUD3BDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbUD3BDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 21:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUD3BDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 21:03:07 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:8867 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S263670AbUD3BDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 21:03:01 -0400
Date: Fri, 30 Apr 2004 03:05:52 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
Message-ID: <20040430010552.GA10323@finwe.eu.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org> <20040429170111.GA24184@finwe.eu.org> <20040429173218.GA2199@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429173218.GA2199@mars.ravnborg.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> > CC [M]  drivers/char/agp/frontend.o
> > CC [M]  drivers/char/agp/generic.o
> > make[3]: *** No rule to make target `drivers/char/agp/isoch.s', needed
> > by `drivers/char/agp/isoch.o'.
> 
> It cannot find the file: isoch.c

Well, yes..

> Did you do a recursive check-out before building the kernel?
> It's in my tree here.

I thought it was because last patch applied, when in fact it was because
of coping kernel tree to my own directory before I applied it...

-rw-r-----    1 root     root        13235 2004-04-04 06:38 isoch.c
       ^

Anyway false alarm, sorry...

bye

-- 
Jacek Kawa
