Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVCDIpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVCDIpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVCDIpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:45:41 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:51934 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S262671AbVCDIpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:45:30 -0500
Message-ID: <42281FD5.10000@keyaccess.nl>
Date: Fri, 04 Mar 2005 09:44:05 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Adrian Bunk <bunk@stusta.de>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>  <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>  <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>  <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>  <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>  <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>  <20050303170808.GG4608@stusta.de> <1109877336.4032.47.camel@tglx.tec.linutronix.de> <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Thu, 3 Mar 2005, Thomas Gleixner wrote:
> 
>>It still does not solve the problem of "untested" releases. Users will
>>still ignore the linus-tree-rcX kernels. 
> 
> 
> .. and maybe that problem is unsolvable. People certainly argued 
> vehemently that anything we do to try to make test releases (renaming etc) 
> won't help.

No, we argued that _if_ you don't do real -rc's no amount of renaming 
will trick people into believing they are (for long). Note how that's 
what has happened now. Your -rc's are -pre's, certainly the first ones 
for each kernel, and that's exactly how people treat them -- that is, 
many avoid them.

Doing -rc1 to release and beyond from that per-release "sucker tree" as 
you call it (I prefer "release tree") makes more sense. This gets you 
real release management and the only thing left to do is appoint the 
release manager.

> So what do you do if you find an unsolvable problem? You don't solve it: 
> you make sure it's not a show-stopper.

It's not unsolveable. Doing real -pre's and -rc's (which means "doing 
doing real -rc's" in addition to the current situation) would at least 
to a degree solve it.

> Sneaky. That's my middle name.

Judging by the fact that apparently you know have to few testers "seeing 
right through Linus" would seem to be everybody else's, though.

Rene.
