Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313318AbSDYQQR>; Thu, 25 Apr 2002 12:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313319AbSDYQQQ>; Thu, 25 Apr 2002 12:16:16 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:12292 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313318AbSDYQQP>;
	Thu, 25 Apr 2002 12:16:15 -0400
Date: Thu, 25 Apr 2002 08:13:52 -0700
From: Greg KH <greg@kroah.com>
To: Alex Walker <alex@x3ja.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.10: 2 OOPs - "BUG at usb.c" and "unable to handle kernel paging request"
Message-ID: <20020425151352.GD19161@kroah.com>
In-Reply-To: <20020424142132.K23497@x3ja.co.uk> <20020425074651.GA17368@kroah.com> <20020425133703.Q23497@x3ja.co.uk> <20020425145450.GA19161@kroah.com> <20020425170413.V23497@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 28 Mar 2002 12:50:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 05:04:13PM +0100, Alex Walker wrote:
> Look! It's Greg!
> 
> On Thu, Apr 25, 2002 at 07:54:50AM -0700, Greg KH wrote:
> > On Thu, Apr 25, 2002 at 01:37:03PM +0100, Alex Walker wrote:
> > > 'ello Greg On Thu, Apr 25, 2002 at 12:46:51AM -0700, Greg KH wrote:
> > > > > Hi, I'm not subscribed - please CC me in any replies.  Two OOps
> > > > > when running 2.5.10, as attached. With attatched config.  First
> > > > > occurs on boot, but doesn't stop the whole system.  The second
> > > > > occurs as I was rebooting - see the attached log to see where
> > > > > they happen.  Any more info required?  Just ask.
> > > > Known problem with the uhci driver right now, just use usb-uhci
> > > > instead (not the ALT UHCI driver) for now until things get
> > > > straightend out.
> > > Yes, that's solved the first oops.  Is the second one related?
> > Probably, does the second one still happen now?
> 
> Sorry, that would have been useful for me to say wouldn't it?  yes it
> does still happen.

Ah, I have no idea.  The ksymoops report doesn't give very much to go
by, so I'll guess that it's not a USB problem :)

thanks,

greg k-h
