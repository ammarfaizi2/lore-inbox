Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319147AbSIDL4u>; Wed, 4 Sep 2002 07:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319148AbSIDL4u>; Wed, 4 Sep 2002 07:56:50 -0400
Received: from employees.nextframe.net ([212.169.100.200]:35055 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S319147AbSIDL4t>; Wed, 4 Sep 2002 07:56:49 -0400
Date: Wed, 4 Sep 2002 14:02:41 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Message-ID: <20020904140241.A123@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <200209041350.21358.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209041350.21358.roy@karlsbakk.net>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Roy

On Wed, Sep 04, 2002 at 01:50:21PM +0200, Roy Sigurd Karlsbakk wrote:
> hi
> 
> I just read in the OS X.2 technote 

So did I :)

> (http://developer.apple.com/technotes/tn2002/tn2053.html#TN001016) that 
> they're writing the panic dump to nvram.
> 
> Is it hard to implement this on Linux?

Doesn`t look like too much work. As far as I can see, from a quick
glance, we have everything we need at hand - just have to write a snippet
of code in traps.c. I`ll give it a whirl now.

> 
> roy
> -- 
> Roy Sigurd Karlsbakk, Datavaktmester
> ProntoTV AS - http://www.pronto.tv/
> Tel: +47 9801 3356
> 

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
