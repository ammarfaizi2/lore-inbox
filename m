Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319155AbSH2Jks>; Thu, 29 Aug 2002 05:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319156AbSH2Jks>; Thu, 29 Aug 2002 05:40:48 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:54287 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S319155AbSH2Jkr>; Thu, 29 Aug 2002 05:40:47 -0400
Date: Thu, 29 Aug 2002 11:44:55 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why it would be good to have AC interdiff patches
Message-ID: <20020829094455.GA18846@louise.pinerecords.com>
References: <20020829074759.GC851@ulima.unil.ch> <20020829081533.GA541@diamond.ipht-jena.de> <20020829091552.GE851@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020829091552.GE851@ulima.unil.ch>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 4 days, 1:59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 3) The time for compilation would be smaller as you modify less files.
> > 
> > Somebody wrote me one time that it is always a good thing to make an
> > "mrproper" after I have applied a patch to kernel sources.
> > 
> > Is that right?
> 
> Well, I never did...

You're asking for serious problems. ld will often not fail when
the ABI changes and evil things *will* happen if a fc ends up
popping nonsense from stack.
