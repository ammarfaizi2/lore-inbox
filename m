Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUADBSR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 20:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUADBSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 20:18:17 -0500
Received: from findaloan.ca ([66.11.177.6]:44430 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S264384AbUADBSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 20:18:15 -0500
Date: Sat, 3 Jan 2004 20:16:26 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040104011626.GB6398@mark.mielke.cc>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Linus Torvalds <torvalds@osdl.org>, Rob Love <rml@ximian.com>,
	rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <200401010634.28559.rob@landley.net> <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl> <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org> <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104000840.A3625@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 12:08:40AM +0100, Andries Brouwer wrote:
> On Sat, Jan 03, 2004 at 02:27:47PM -0800, Linus Torvalds wrote:
> > And then a high-quality implementation actually ends up being 
> > _detrimental_. It's hiding problems that can still happen, they just 
> > happen rarely enough that the bugs don't get found and fixed.
> Empty talk. This is not about finding and fixing bugs.
> We know very precisely what properties the NFS protocol has.
> Now one can have a system that works as well as possible with NFS.
> And one can have a worse system.

It seems to me that as long as /dev is always a local mount (tmpfs in
the case of an NFS-root installation), it doesn't really matter. Maintaining
system-specific information on a remote machine seems dirty, and something
that shouldn't be *expected* to work. You wouldn't expect /proc to work
over NFS, would you? :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

