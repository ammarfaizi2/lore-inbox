Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSJ1Kct>; Mon, 28 Oct 2002 05:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbSJ1Kct>; Mon, 28 Oct 2002 05:32:49 -0500
Received: from employees.nextframe.net ([212.169.100.200]:39672 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S263215AbSJ1Kcs>; Mon, 28 Oct 2002 05:32:48 -0500
Date: Mon, 28 Oct 2002 11:47:20 +0100
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in kswapd, 2.4.19 kernel and before
Message-ID: <20021028114720.D9001@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <20021028102439.GB13490@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028102439.GB13490@carfax.org.uk>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hugo, 

On Mon, Oct 28, 2002 at 10:24:39AM +0000, Hugo Mills wrote:
>    Hi,
> 
>    This is the third time I've tried to report this problem, with no
> response so far. One last try. If you're not interested, please tell
> me and I won't bother you any more...
> 
>    I'm getting regular oopsen in kswapd on my 2.4.19 kernel. They
> generally appear to happen while running Amanda (a tape backup
> utility) -- although I've not identified exactly which component of
> Amanda triggers it. The machine is lightly stressed with regard to
> memory usage, although I suspect much of it is (currently) swapped out
> (I'm running postgres and apache, but they don't get much use at the
> moment):

[snip]

I think this is the same issue I reported here : 
http://marc.theaimsgroup.com/?l=linux-kernel&m=103226236223247&w=2

Upgrading to 2.4.20-pre7 has solved the problem for me ... Haven`t
had time to look into what actually caused/fixed it. 

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
