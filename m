Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262343AbREUUWg>; Mon, 21 May 2001 16:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbREUUW2>; Mon, 21 May 2001 16:22:28 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:59396 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S262215AbREUUWL>;
	Mon, 21 May 2001 16:22:11 -0400
Message-ID: <20010520231330.E2647@bug.ucw.cz>
Date: Sun, 20 May 2001 23:13:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Gooch <rgooch@ras.ucalgary.ca>, Alexander Viro <viro@math.psu.edu>
Cc: Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <200105200222.f4K2Mto02608@mobilix.ras.ucalgary.ca> <Pine.GSO.4.21.0105192232560.7162-100000@weyl.math.psu.edu> <200105200251.f4K2pHT02925@mobilix.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200105200251.f4K2pHT02925@mobilix.ras.ucalgary.ca>; from Richard Gooch on Sat, May 19, 2001 at 10:51:17PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The transaction(2) syscall can be just as easily abused as ioctl(2) in
> > > this respect. People can pass pointers to ill-designed structures very
> > 
> > Right. Moreover, it's not needed. The same functionality can be
> > trivially implemented by write() and read(). As the matter of fact,
> > had been done in userland context for decades. Go and buy
> > Stevens. Read it. Then come back.
> 
> I don't need to read it. Don't be insulting. Sure, you *can* use a
> write(2)/read(2) cycle. But that's two syscalls compared to one with
> ioctl(2) or transaction(2). That can matter to some applications.

I just don't think so. Where did you see performance-critical use of
ioctl()?
							       Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
