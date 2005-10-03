Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVJCER0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVJCER0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVJCERZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:17:25 -0400
Received: from smtpout4.uol.com.br ([200.221.4.195]:17911 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S932146AbVJCERZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:17:25 -0400
Date: Mon, 3 Oct 2005 01:17:19 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051003041719.GA5576@ime.usp.br>
Mail-Followup-To: Grant Coady <grant_lkml@dodo.com.au>,
	Nigel Cunningham <ncunningham@cyclades.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050927111038.GA22172@ime.usp.br> <1127863912.4802.52.camel@localhost> <20051001213655.GE6397@ime.usp.br> <oh8uj15lvipg3bshv7j82j27j11l67ds49@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oh8uj15lvipg3bshv7j82j27j11l67ds49@4ax.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Grant, Nigel and others following this thread.

On Oct 02 2005, Grant Coady wrote:
> On Sat, 1 Oct 2005 18:36:55 -0300, Rogério Brito <rbrito@ime.usp.br> wrote:
> >I removed what was extracted right away and tried again to extract
> >the tree (at this point, suspecting even that something in software
> >had problems). The problem with bzip2 occurred again. Then, I
> >rebooted the system an the problem magically went away.
> 
> This rings a bell, recently I reported a problem:
>   http://www.uwsg.iu.edu/hypermail/linux/kernel/0508.1/1332.html

Thanks for the information. I am on-and-off experimenting with
goldmemory and memtester86+ to see if I can find something with more
than 512MB that is stable.

I am, right now, using 512MB + 256MB slowed down to PC100 speeds. It
seems to be stable with this configuration (having survived some memory
tests, the decoding of lots of FLAC files in a row and using the machine
as usual---with low consumption things like mutt and browsing with
lynx).

> Turned out to be bad memory stick :o)

The thing is that any stick alone doesn't seem to generate a problem.
Only when they are used simultaneously

I will test it more to see what may be wrong with my setup. :-( I still
have not isolated and understood the problem completely. :-(


Thanks for the feedback, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
