Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269063AbUJQFvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269063AbUJQFvA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 01:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUJQFvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 01:51:00 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:5262 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269063AbUJQFu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 01:50:57 -0400
Subject: Re: Building on case-insensitive systems
From: Albert Cahalan <albert@users.sf.net>
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, sam@ravnborg.org
In-Reply-To: <4171F741.2070209@kegel.com>
References: <1097989574.2674.14246.camel@cube>  <4171F741.2070209@kegel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1097991836.2666.14274.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2004 01:43:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 00:38, Dan Kegel wrote:
> Albert Cahalan wrote:
> >>There are today ~1400 files named *.S in the tree, but none named *.s.
> >>So my idea was to do it like:
> >>*.S => *.asm => *.o
> > 
> > The logic is sound, but... yuck!
> 
> Yes, but worth it, I think.  Maybe some configure magic could
> pick .asm as the suffix only when building on case-insensitive
> filesystems, if that's the only way to make this palatable
> to those devoted to the .s/.S idiom.

I'm more devoted to ".s" than I am to ".S", so if anybody
wants to rename 1400 files, go right ahead.   >:-)

> >>Btw. this is not about "case-challenged" filesystems in general.
> >>This is about making the kernel usefull out-of-the-box for the
> >>increasing embedded market. Less work-around patces needed the
> >>better. And these people are oftenb ound to Windoze boxes - for
> >>different reasons. And the individual developer may not be able
> >>to change this.
> > 
> > The difficulty in building on a case-insensitive filesystem may
> > be the only hope these developers have for escaping Windows.
> > You turn "we must have Linux build systems to build our product"
> > into the less effective "we want Linux".       
> > 
> > For the sake of these suffering developers, it would be better
> > to make sure that building Linux on Windows is a lost cause.
> > We could name a file "con" or "a:foo" for example.
> 
> You are betting that you can force developers to switch away
> from Windows and MacOSX workstations.

Actually, I'm betting that "required to build product"
is a magic phrase that overrides corporate IT's desire
to brutally enforce a Microsoft-only environment.

If the developers themselves actually want Windows, well,
only a psychologist can help them.

For MacOS X, simply mount a UFS filesystem.


