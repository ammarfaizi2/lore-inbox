Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTBTRLN>; Thu, 20 Feb 2003 12:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTBTRLN>; Thu, 20 Feb 2003 12:11:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:61196 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265939AbTBTRLM>;
	Thu, 20 Feb 2003 12:11:12 -0500
Date: Thu, 20 Feb 2003 18:21:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
Message-ID: <20030220172116.GA978@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030220062323.GX351@lug-owl.de> <Pine.LNX.3.96.1030220060638.14551A-101000@gatekeeper.tmr.com> <20030220113624.GP351@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220113624.GP351@lug-owl.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 12:36:24PM +0100, Jan-Benedict Glaw wrote:
> 
> This reminds me that I wanted to have a look at an additional feature -
> building the kernel _not_ within its source tree. So I wouldn't need to
> place 10 copies of the kernel onto disk / into memory...
> 
> Haven't I seen patches flyin' around? Anyone?

I have made a patch that enabled that feature which I posted some
time ago. I'm reworking it for the moment, awaiting a few pending
kbuild changes + I need to put a bit more work in the script.

Last version posted had problems with oprofile and xfs - and
I do not think ia64 will build with current version.

Expect something to show up within a few weeks.

	Sam
