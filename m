Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269538AbRHCS2P>; Fri, 3 Aug 2001 14:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269543AbRHCS2F>; Fri, 3 Aug 2001 14:28:05 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12555 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269538AbRHCS1y>; Fri, 3 Aug 2001 14:27:54 -0400
Date: Fri, 3 Aug 2001 20:28:02 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803202802.F31468@emma1.emma.line.org>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org> <01080219261601.00440@starship> <20010802193750.B12425@emma1.emma.line.org> <20010803093057.Y12470@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010803093057.Y12470@redhat.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Stephen Tweedie wrote:

> > > The prescription for symlinks is, if you want them safely on disk you 
> > > have to explicitly fsync the containing directory.
> > 
> > Yes, and it doesn't matter, since MTAs don't use symlinks (symlinks
> > waste inodes on most systems).
> 
> Irrelevant.   We're talking about what makes sensible semantics, not
> what assumptions any specific application makes.  It makes no sense to
> say that dirsync won't affect symlinks just because some existing
> applications don't rely on that!

It's rather my imagination that tracking hard links might be easier than
symlinks because hard links share the inode number. A more advanced (and
complex) implementation might prove the imagination wrong. I don't want
to consider which one is more efficient.

-- 
Matthias Andree
