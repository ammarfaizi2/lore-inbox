Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269084AbTCBC0i>; Sat, 1 Mar 2003 21:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269086AbTCBC0h>; Sat, 1 Mar 2003 21:26:37 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:51982 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S269084AbTCBC0g>; Sat, 1 Mar 2003 21:26:36 -0500
Date: Sat, 1 Mar 2003 18:36:50 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Message-ID: <20030302023649.GA30797@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030301082126.56c00418.coyote1@cytanet.com.cy> <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk> <20030301150350.GA27794@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301150350.GA27794@lug-owl.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 04:03:50PM +0100, Jan-Benedict Glaw wrote:
> On Sat, 2003-03-01 14:55:58 +0000, John Bradford <john@grabjohn.com>
> wrote in message <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>:
> > > It's the mandrake default AFAIK.  I don't know what all that stuff is, 
> > > so I don't mess with it.  My installation does "feel" bloated (very
> > > unscientific opinion): it "feels" much less responsive in the GUI
> > 
> > /dev/hda2	/	ext3	defaults		1  1
> > 
> > which you can change to
> > 
> > /dev/hda2	/	ext3	defaults, noatime	1  1
>                           you loose -----^
> 
> > This is a bit off-topic, but in my experience is about the best way to
> > increase performance on old, (and not so old), hardware, apart from
> > compiling a custom kernel.  Without noatime, every time you read a
> > file, the current date and time is written to the disk.  With noatime,
> > it's only recorded for a write.  Almost no programs use the access
> > time data.
> 
> Except some email clients...

And as you and i already hashed out on the rsync list mutt is
perfectly happy and fully functional with noatime,nodiratime
because it updates the atime manually which still works.
As the headers indicate i'm using mutt,  It spots new mail 
in other mboxes just fine with noatime turned on.  I get the
"Inc:" count, c<tab> works, and folder lists indicate
correctly which folders have been updated since last visit.

Perhaps you are thinking of another MUA or an oooold version
of mutt?



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
