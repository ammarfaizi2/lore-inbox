Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313199AbSDYP5P>; Thu, 25 Apr 2002 11:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313293AbSDYP5O>; Thu, 25 Apr 2002 11:57:14 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:8196 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313199AbSDYP5N>;
	Thu, 25 Apr 2002 11:57:13 -0400
Date: Thu, 25 Apr 2002 07:54:50 -0700
From: Greg KH <greg@kroah.com>
To: Alex Walker <alex@x3ja.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.10: 2 OOPs - "BUG at usb.c" and "unable to handle kernel paging request"
Message-ID: <20020425145450.GA19161@kroah.com>
In-Reply-To: <20020424142132.K23497@x3ja.co.uk> <20020425074651.GA17368@kroah.com> <20020425133703.Q23497@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 28 Mar 2002 12:50:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 01:37:03PM +0100, Alex Walker wrote:
> 'ello Greg
> 
> On Thu, Apr 25, 2002 at 12:46:51AM -0700, Greg KH wrote:
> > > Hi, I'm not subscribed - please CC me in any replies.  Two OOps when
> > > running 2.5.10, as attached. With attatched config.  First occurs on
> > > boot, but doesn't stop the whole system.  The second occurs as I was
> > > rebooting - see the attached log to see where they happen.  Any more
> > > info required?  Just ask.
> > Known problem with the uhci driver right now, just use usb-uhci instead
> > (not the ALT UHCI driver) for now until things get straightend out.
> 
> Yes, that's solved the first oops.  Is the second one related?

Probably, does the second one still happen now?

greg k-h
