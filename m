Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270191AbRHGW1E>; Tue, 7 Aug 2001 18:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269504AbRHGW0y>; Tue, 7 Aug 2001 18:26:54 -0400
Received: from bender.toppoint.de ([195.244.243.2]:37512 "EHLO
	mail.toppoint.de") by vger.kernel.org with ESMTP id <S270199AbRHGW0n>;
	Tue, 7 Aug 2001 18:26:43 -0400
>Received: (from netzwurm@localhost)
	by gandalf.discordia (8.9.3/8.9.3/Debian 8.9.3-21) id XAA30316;
	Tue, 7 Aug 2001 23:39:21 +0200
Date: Tue, 7 Aug 2001 23:39:21 +0200
From: David Spreen <david@spreen.de>
To: Ted Unangst <tedu@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: summary Re: encrypted swap
Message-ID: <20010807233921.B30244@foobar.toppoint.de>
In-Reply-To: <fa.g4fleqv.1mle133@ifi.uio.no> <Pine.GSO.4.31.0108071419300.2838-100000@cardinal0.Stanford.EDU>
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0108071419300.2838-100000@cardinal0.Stanford.EDU>; from tedu@stanford.edu on Tue, Aug 07, 2001 at 02:34:48PM -0700
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 02:34:48PM -0700, Ted Unangst wrote:
> conclusion:  if your data is that valuable, you will need a small army to
> protect it.  don't bother encrypting swap, because guns are a better means
> of protection.  

NAK. Of course I have the united states army in front of my notebook
to protect my pronsite passwds. But see, the army makes my notebook 
an interesting target for data-thiefs, right? So I want encrypted swap
as an additional feature.
Okay stop kidding, of course crypted swap is no allround solution, but 
a step to harden your security issues. I don't want to make you using
it, but I can think of people who would want to including myself.

> if your data is only semi-valuable, or private that you
> wouldn't want random others to read it, then swap encryption is good.
> it's a nice feature that some people might like to have.  does it solve
> every problem? no.  but the people in the edge cases are most likely very
> aware of the possibilities.

ACK.

> implementation paper:
> http://www.openbsd.org/papers/swapencrypt.ps

Thank you, this was what I meant when I wrote of some BSD :).

Okay, so I got some ideas how to implement, the kernel-related
thing with an automatic generated key and the kerneli-issue.

I tried to get kerneli working with swap some time ago and it didn't work.
Has the behavour changed? In the crypto HOWTO linked on kerneli.org is 
still said that swap encryption doesn't work (but I don't know when the
last release was written).

so long & thanks for your suggestions...

David
-- 
  __          _              | David "netzwurm" Spreen      Kiel, Germany
 / _|___  ___| |__  __ _ _ _ | http://www.netzwurm.cc/      david@spreen.de
|  _/ _ \/ _ \ '_ \/ _` | '_|| gnupg key (on keyservers):   C8B6823A
|_| \___/\___/_.__/\__,_|_|  | CellPhone:                   +49 173 3874061

