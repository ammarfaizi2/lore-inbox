Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVFQRus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVFQRus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVFQRus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:50:48 -0400
Received: from CPE000f6690d4e4-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.134]:62223
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S262035AbVFQRu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:50:27 -0400
Date: Fri, 17 Jun 2005 13:57:36 -0400
To: Chris Friesen <cfriesen@nortel.com>
Cc: Robert Love <rml@novell.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify, improved.
Message-ID: <20050617175735.GA2075@tentacle.dhs.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au> <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy> <42B2EE31.9060709@nortel.com> <1119023078.3949.115.camel@betsy> <42B2FD00.9060102@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B2FD00.9060102@nortel.com>
User-Agent: Mutt/1.5.9i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 10:40:32AM -0600, Chris Friesen wrote:
> Robert Love wrote:
> >On Fri, 2005-06-17 at 09:37 -0600, Chris Friesen wrote:
> 
> >>On a newsgroup someone was using inotify, but was asking if there was 
> >>any way to also determine which process/user had caused the notification.
> 
> >I have been hesitant, though.  I do not want feature creep to be a
> >deterrent to acceptance into the Linux kernel.
> 
> Absolutely.
> 
> >I also think that there could be arguments about security.
> >...can we
> >say that read rights are enough for a unprivileged user to know that
> >root at pid 820 is writing the file?  I don't know.
> 
> I'm sure some reasonable rules could be determined.  Maybe you'd need to 
> be the owner of the file to get the extra info, with root able to 
> monitor everything.
> 
> Maybe there should be a way to load plugins into inotify (something like 
> netfilter) so that people load modules to send themselves whatever 
> information they want...

This is probably a good idea for the _audit_ system. Inotify was
designed to do 1 task well, and it should stay that way.

John
