Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTDKPpN (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 11:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbTDKPpN (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 11:45:13 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49805 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264412AbTDKPpM convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 11:45:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Christer Weinigel <christer@weinigel.se>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kernel support for non-english user messages
Date: Fri, 11 Apr 2003 08:56:16 -0700
User-Agent: KMail/1.4.1
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, root@chaos.analogic.com,
       Frank Davis <fdavis@si.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E93A958.80107@si.rr.com> <1050003748.12494.42.camel@dhcp22.swansea.linux.org.uk> <m31y09uadx.fsf@localhost.localdomain>
In-Reply-To: <m31y09uadx.fsf@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304110856.16812.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 April 2003 05:48 pm, Christer Weinigel wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > On Thu, 2003-04-10 at 21:13, Trond Myklebust wrote:
> > > Which features in particular were you thinking would be worth porting?
> >
> > Give me the clustering support 8)
>
> One of the things I really liked with VMS was the centralized logging
> in a clustered system.  I'd very much like to be able to say "give me
> all syslog messages for the mail subsystem at this severity level or
> above" instead of having to play around with /etc/syslog.conf,
> restarting syslogd and tail -f.  Of course this isn't a kernel
> problem, it's something that should be implemented in syslog, but it's
> just an example of a good idea in VMS.


Are you familar with IBM's Event Logging? 

http://evlog.sourceforge.net/

Event Logging works well in a clustered environment. You can have your logs go 
to one central location and, with the help of a plug-in, you could dump the 
messages off into a database for easy queries. Mark Megerian at IBM is 
working with a DB2 plug-in. Here's the thread on the evlog mailing list:

http://sourceforge.net/mailarchive/forum.php?thread_id=1785428&forum_id=659

Thanks,

Dan


>   /Christer

