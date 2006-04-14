Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWDNOye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWDNOye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWDNOyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:54:24 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:30873 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964982AbWDNOyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:54:23 -0400
Date: Fri, 14 Apr 2006 10:54:19 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Direct writing to the IDE on panic?
In-Reply-To: <1145026327.17531.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0604141048260.11438@gandalf.stny.rr.com>
References: <1144936547.1336.20.camel@localhost.localdomain> 
 <1145024914.17531.21.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0604141023240.11098@gandalf.stny.rr.com>
 <1145026327.17531.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2006, Alan Cox wrote:

> On Gwe, 2006-04-14 at 10:27 -0400, Steven Rostedt wrote:
> > Nice point.  But fortunately, this is for a custom application running on
> > an embedded device, such that the data that is on another part of the disk
> > (which btw is an IDE flash) is just the application and the rest of the
> > OS.  So, although a bad write to the disk will cause much more work, it
> > wont destroy data that cant be replaced.
>
> If you know the controller as well then you are correct in assuming the
> code to do the dump is very simple indeed providing you stick to PIO,
> especially if you know the set up is already done before crash
>

Thank you very much for your input Alan!

Now my strength in IDE is not that strong, hence the reason I was asking
if this was done before.  I'd like to look at some examples before I go
ahead and figure it out on my own.  I'm sure that I'm going to need to do
a rewrite for our specific configuration, but looking at others work might
make things easier.

Since this is all under GPL (my customer will give all the source to who
ever they distribute it to), I was hoping to take advantage of free
software here and not completely reinvent the wheel (and destroying it
along the way ;)

Thanks,

-- Steve

