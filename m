Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262945AbREWBwi>; Tue, 22 May 2001 21:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262946AbREWBw2>; Tue, 22 May 2001 21:52:28 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:41826 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S262945AbREWBwW>; Tue, 22 May 2001 21:52:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: John Stoffel <stoffel@casc.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
In-Reply-To: Your message of "Tue, 22 May 2001 11:24:54 +0200."
             <01052211245404.06233@starship> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 May 2001 11:51:31 +1000
Message-ID: <5810.990582691@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001 11:24:54 +0200, 
Daniel Phillips <phillips@bonn-fries.net> wrote:
>On Tuesday 22 May 2001 02:59, Keith Owens wrote:
>> # Not a real dependency, this checks for hand editing of .config.
>> $(KBUILD_OBJTREE)include/linux/autoconf.h: $(KBUILD_OBJTREE).config
>>         @echo Your .config is newer than include/linux/autoconf.h,
>> this should not happen. @echo Always run make one of
>> "{menu,old,x}config" after manually updating .config. @/bin/false
>
>Ahem.  What is wrong with revalidating it automatically?  *Then* if there's a
>problem, bother the user.

Revalidate using which tool?  Did the user even mean to edit .config?
This is a case where the user has to decide what to do.

