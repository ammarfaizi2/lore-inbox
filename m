Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317293AbSFGPHN>; Fri, 7 Jun 2002 11:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSFGPHM>; Fri, 7 Jun 2002 11:07:12 -0400
Received: from users.ccur.com ([208.248.32.211]:19865 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S317293AbSFGPHL>;
	Fri, 7 Jun 2002 11:07:11 -0400
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200206071506.PAA16583@rudolph.ccur.com>
Subject: Re: [PATCH] 2.4.19-pre10 bug in disable_APIC_timer
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 7 Jun 2002 11:06:09 -0400 (EDT)
Cc: joe.korty@ccur.com (Joe Korty), marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <1023465508.25523.43.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jun 07, 2002 04:58:28 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2002-06-07 at 15:49, Joe Korty wrote:
> > 
> > I am calling it from some cpu shielding code I've written and am
> > debugging.
> 
> So the __init isnt actually a bug. It might be an appropriate change if
> your code ever becomes part of the main tree thats all

True.  In that case, an __init should be added to enable_APIC_timer.
