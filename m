Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261790AbREVOdn>; Tue, 22 May 2001 10:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbREVOdf>; Tue, 22 May 2001 10:33:35 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4619 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261796AbREVOdV>; Tue, 22 May 2001 10:33:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Keith Owens <kaos@ocs.com.au>, John Stoffel <stoffel@casc.com>
Subject: Re: Background to the argument about CML2 design philosophy
Date: Tue, 22 May 2001 11:24:54 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2436.990493144@kao2.melbourne.sgi.com>
In-Reply-To: <2436.990493144@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Message-Id: <01052211245404.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 May 2001 02:59, Keith Owens wrote:
>
> # Not a real dependency, this checks for hand editing of .config.
> $(KBUILD_OBJTREE)include/linux/autoconf.h: $(KBUILD_OBJTREE).config
>         @echo Your .config is newer than include/linux/autoconf.h,
> this should not happen. @echo Always run make one of
> "{menu,old,x}config" after manually updating .config. @/bin/false

Ahem.  What is wrong with revalidating it automatically?  *Then* if there's a
problem, bother the user.

"No news is good news".

--
Daniel

