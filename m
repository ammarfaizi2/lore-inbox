Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTLGKcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 05:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTLGKcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 05:32:53 -0500
Received: from legolas.restena.lu ([158.64.1.34]:20426 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264401AbTLGKcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 05:32:52 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Craig Bradney <cbradney@zip.com.au>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070756987.1987.7.camel@big.pomac.com>
References: <1070739194.1985.4.camel@big.pomac.com>
	 <1070756427.2093.2.camel@athlonxp.bradney.info>
	 <1070756987.1987.7.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1070793169.2079.10.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 07 Dec 2003 11:32:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-07 at 01:29, Ian Kumlien wrote:
> On Sun, 2003-12-07 at 01:20, Craig Bradney wrote:
> > On Sat, 2003-12-06 at 20:33, Ian Kumlien wrote:
> > > Hi, i'm now running this patch and it survived my grep in /usr/src.
> > > 
> > > It's mainly a correction of the apic patch and the ACPI halt disconnect
> > > patch that was originally done for 2.6...
> > 
> > Correction? how so? code looks the same, although the line numbers are
> > completely different for mpparse.c and at that location there is
> > different code. (Havent checked the disconnect)
> 
> this is for 2.4.23 =)

duh.. ok :)


> > Or do u just mean combination of the two patches?
> 
> Combination + for 2.4.23
> 
> > > I'll get back to you about uptime, but i think this is it... 
> > 
> > Why do you think the disconnect is also related? (given some are just
> > running the APIC patch and having (less/)no issues?
> 
> Since i had issues with just the apic patch, as stated in my mail.

oic.. sorry.. must have missed that.
> 
> > > Although i would prefer a not so workaroundish approach =)
> > 
> > 23 hrs now.. 
> 
> I'm at 5:06 and thats a record for it running with apic.

1d 9h here now..

I remembered I also dont have preempt still, but I am happy with it if
it stays like this. The next time I need to reboot (or get a hang), I'll
recompile with preempt it and try again.

Craig

