Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSFIRoo>; Sun, 9 Jun 2002 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSFIRon>; Sun, 9 Jun 2002 13:44:43 -0400
Received: from dsl-213-023-043-234.arcor-ip.net ([213.23.43.234]:13803 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313419AbSFIRon>;
	Sun, 9 Jun 2002 13:44:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jan Pazdziora <adelton@informatics.muni.cz>, christoph@lameter.com
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Date: Sun, 9 Jun 2002 19:44:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <Pine.LNX.4.33.0206081849010.5464-100000@melchi.fuller.edu> <20020609184435.A27442@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17H6ja-0003Ye-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 June 2002 18:44, Jan Pazdziora wrote:
> On Sat, Jun 08, 2002 at 06:53:49PM -0700, christoph@lameter.com wrote:
> > I just tried the patch adding symlinks to the vfat fs. It was submitted
> > back at the end of last year but it does not seem to have made it into the
> > kernel sources. I was unable to find a discussion on this. Symlink support
> > in vfat is really useful when you are sharing a vfat volume on a dual
> > booted system. I tried patching a 2.5.X kernel but the page cache changes
> > mean that the patch needs reworking.
> > 
> > Do you have any updates to the patch Jan?
> 
> No, I don't. I did not receive any feedback since I sent in the patch
> to linux-kernel, so I concluded that people do not consider lack
> of shortcut/symlink support a problem. For me it's something that
> would be nice to have but I don't feel like pushing it in.

More often than not, when a post doesn't get any responses it's a good sign: 
it means nobody disagrees.  It can of course also mean that nobody read it, 
but that's not very likely on this list, especially if you put [RFC] in the 
subject line.

> I might be able to upgrade the patch for the 2.5 kernal line, but
> I'd like to hear some comments about the code in general. 

To increase the chance of getting comments, cc people who might be 
interested, particularly subsystem maintainers.  For this one, cc'ing fsdevel 
would be a good idea too.  It's a low volume list, but the traffic on it does 
get read by many people with a clue.  If you want to be really sure of 
getting feedback, cc Linus or Al Viro.

Personally, it sounds like support for shortcuts as symlinks is a natural and 
needed improvement, though I haven't looked at the the internal details.  
(Shortcuts arrived in Microsoft-land at about the time I lost interest.)  I'm 
kind of surprised the support isn't already there.  Perhaps you could briefy 
describe how shortcuts work on vfat?

-- 
Daniel
