Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbRCZTuX>; Mon, 26 Mar 2001 14:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRCZTuQ>; Mon, 26 Mar 2001 14:50:16 -0500
Received: from [195.63.194.11] ([195.63.194.11]:14867 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132557AbRCZTt4>; Mon, 26 Mar 2001 14:49:56 -0500
Message-ID: <3ABF9A53.4657FADC@evision-ventures.com>
Date: Mon, 26 Mar 2001 21:36:51 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Matthew Wilcox <matthew@wil.cx>, Andreas Dilger <adilger@turbolinux.com>,
        LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <20010326181803.F31126@parcelfarce.linux.theplanet.co.uk> <200103261747.f2QHlEX19564@webber.adilger.int> <20010326190945.I31126@parcelfarce.linux.theplanet.co.uk> <m17l1cz88v.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Matthew Wilcox <matthew@wil.cx> writes:
> 
> > On Mon, Mar 26, 2001 at 10:47:13AM -0700, Andreas Dilger wrote:
> > > What do you mean by problems 5 years down the road?  The real issue is that
> > > this 32-bit block count limit affects composite devices like MD RAID and
> > > LVM today, not just individual disks.  There have been several postings
> > > I have seen with people having a problem _today_ with a 2TB limit on
> > > devices.
> >
> > people who can afford 2TB of disc can afford to buy a 64-bit processor.
> 
> Currently that doesn't solve the problem as block_nr is held in an int.
> And as gcc compiles an int to a 32bit number on a 64bit processor, the
> problem still isn't solved.
> 
> That at least we need to address.

And then you must face the fact that there may be the need for
some of the shelf software, which isn't well supported on 
correspondig 64 bit architectures... as well. So the
arguemnt doesn't hold up to the reality in any way.
BTW. For many reasons 32 bit architecutres are in
respoect of some application shemes *faster* the 64.
Ultra III in 64 mode just crawls in comparision to 32.
Alpha - unfortulatly an orphaned and dyring archtecutre... which
is not well supported by sw verndors...
