Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313022AbSC0Obj>; Wed, 27 Mar 2002 09:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313023AbSC0Ob3>; Wed, 27 Mar 2002 09:31:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33807 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313022AbSC0ObV>; Wed, 27 Mar 2002 09:31:21 -0500
Date: Wed, 27 Mar 2002 09:29:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19pre4-ac1
In-Reply-To: <15521.15136.643851.483671@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.3.96.1020327092302.12827B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Neil Brown wrote:

> I think I felt that macros would be very noisy for relatively little
> gain.
> However I guess
> 
> #define ST 1  /* status*/
> #define FH 17 /* filehandle with length */
> #define AT 22 /* attributes */
> #define WC 7  /* WCC attribute prefix */
> 
> might make things clearer without being too noisy....

  A true member of the "never use a long name when a short one will do" 
school? You really could sacrifice a few more bytes and use more
descriptive names which mean something without looking at the macro
definition... 

  Whatever, coding style is personal, I make mine as readable as possible
because the next person struggling to understand it in a few years is
likely to still be me.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

