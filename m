Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbREXMxV>; Thu, 24 May 2001 08:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbREXMxL>; Thu, 24 May 2001 08:53:11 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:4363 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261786AbREXMxA>; Thu, 24 May 2001 08:53:00 -0400
Date: Thu, 24 May 2001 14:52:59 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: question: permission checking for network filesystem
Message-ID: <20010524145259.A32022@artax.karlin.mff.cuni.cz>
In-Reply-To: <20010520172948.A27935@artax.karlin.mff.cuni.cz> <200105220602.f4M62N364271@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105220602.f4M62N364271@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, May 22, 2001 at 02:02:23AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > open mode has 4 bits: read, write, append and execute.
> 
> I hope "write" and "append" interact nicely, giving 4 choices.
> 
> 00 no write
> 01 append only
> 10 overwrite only (no file size change)
> 11 full write, append, truncate, etc.

... that's 1) Wrong 2) I need 4 bits ... that's 16 choices.

It's wrong because append is specified in addition to write (for open syscall).

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
