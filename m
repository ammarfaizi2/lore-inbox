Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTLDDij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 22:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTLDDij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 22:38:39 -0500
Received: from c06284a.rny.bostream.se ([217.215.27.171]:45326 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S262074AbTLDDig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 22:38:36 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16334.44085.362449.278626@pc7.dolda2000.com>
Date: Thu, 4 Dec 2003 04:38:29 +0100
To: Greg KH <greg@kroah.com>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is hotplug a kernel helper?
In-Reply-To: <20031204022911.GA23761@kroah.com>
References: <16334.31260.278243.22272@pc7.dolda2000.com>
	<20031204011357.GA22506@kroah.com>
	<16334.38227.433336.514399@pc7.dolda2000.com>
	<20031204022911.GA23761@kroah.com>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > On Thu, Dec 04, 2003 at 03:00:51AM +0100, Fredrik Tolf wrote:
 > > Greg KH writes:
 > >  > On Thu, Dec 04, 2003 at 01:04:44AM +0100, Fredrik Tolf wrote:
 > >  > > If you don't mind me asking, I would like to know why the kernel calls
 > >  > > a usermode helper for hotplug events? Wouldn't a chrdev be a better
 > >  > > solution (especially considering that programs like magicdev could
 > >  > > listen in to it as well)? 
 > >  > 
 > >  > Please see the archives for why this is, it's been argued many times.
 > > 
 > > I am sincerely sorry for being a bother, but I have spent several
 > > hours searching far and wide for information on it, both in the
 > > archives and generally on the web, without any luck in finding
 > > anything. If it's not too much to ask, would you be as kind as to
 > > provide a pointer?
 > 
 > Here was the latest thread where this was brought up:
 > 	http://marc.theaimsgroup.com/?t=105544548100008
 > 
 > I would suggest reading this post from Linus for a quick summary:
 > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=105552804303171
 > 

Thank you for those references. I must have mistyped something while
searching, since all the keywords I searched for were in the
text... Sorry for wasting your time on that.

 > > Btw., Is there any preferred method of announcing hotplug events to
 > > user interfaces?
 > 
 > Yes there is a standard.  Have you read the docs at
 > http://linux-hotplug.sf.net/ ?  Also my 2001 OLS paper details the
 > format the messages should be in, but it's a bit out of date as to the
 > new values that the 2.6 kernel sends.

No, I haven't. I just put that question in the mail as a side-thing. I
had not expected more than a yes/no reply. In any case, I will read
it. Thanks again.

 > What do you want to use the hotplug interface for that it currently does
 > not do?

Admittedly, I'm still using the RH8 hotplug scripts, and I suspect
improvements have been made since then. I was mainly looking for a way
to auto-mount USB mass storage devices without having to reconfigure
anything as root. I have all the info I need now, though.

Thank you very much for your help.

Fredrik Tolf

