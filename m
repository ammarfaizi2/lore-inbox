Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSDYMhL>; Thu, 25 Apr 2002 08:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSDYMhK>; Thu, 25 Apr 2002 08:37:10 -0400
Received: from smokey.blackcatnetworks.co.uk ([212.135.138.139]:24467 "EHLO
	smokey.blackcatnetworks.co.uk") by vger.kernel.org with ESMTP
	id <S313114AbSDYMhI>; Thu, 25 Apr 2002 08:37:08 -0400
Date: Thu, 25 Apr 2002 13:37:03 +0100
From: Alex Walker <alex@x3ja.co.uk>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.10: 2 OOPs - "BUG at usb.c" and "unable to handle kernel paging request"
Message-ID: <20020425133703.Q23497@x3ja.co.uk>
In-Reply-To: <20020424142132.K23497@x3ja.co.uk> <20020425074651.GA17368@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'ello Greg

On Thu, Apr 25, 2002 at 12:46:51AM -0700, Greg KH wrote:
> > Hi, I'm not subscribed - please CC me in any replies.  Two OOps when
> > running 2.5.10, as attached. With attatched config.  First occurs on
> > boot, but doesn't stop the whole system.  The second occurs as I was
> > rebooting - see the attached log to see where they happen.  Any more
> > info required?  Just ask.
> Known problem with the uhci driver right now, just use usb-uhci instead
> (not the ALT UHCI driver) for now until things get straightend out.

Yes, that's solved the first oops.  Is the second one related?

Alex

-- 
Alex
