Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290652AbSBFQjT>; Wed, 6 Feb 2002 11:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290664AbSBFQi7>; Wed, 6 Feb 2002 11:38:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64772 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290652AbSBFQis>; Wed, 6 Feb 2002 11:38:48 -0500
Date: Wed, 6 Feb 2002 11:37:48 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <2006875340.1012946564@[195.224.237.69]>
Message-ID: <Pine.LNX.3.96.1020206112758.7298F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Alex Bligh - linux-kernel wrote:

  May I suggest that you have you favorite install script put a copy in
/boot instead? I also hacked my startup to Slink in boot to the current
modules directory, SystemMap and boot kernel.

> I would be surprised if there is anyone on this list
> who has not lost at some point either the .config, the
> kysms, or something similar associated with at least
> one build they've made.

  Or forgotten to make oldconfig, or lots of other things. But that
doesn't make a good argument for putting the config permanently in /proc
instead of saving it if you want it, does it? If you could remember to
make the module with the config, you could remember to save it. Or even
have modules_install save the info in a file in the modules directory,
that would get the info without locking it in memory.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

