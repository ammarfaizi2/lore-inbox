Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRCXJsW>; Sat, 24 Mar 2001 04:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRCXJsL>; Sat, 24 Mar 2001 04:48:11 -0500
Received: from james.kalifornia.com ([208.179.59.2]:40813 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131625AbRCXJsA>; Sat, 24 Mar 2001 04:48:00 -0500
Message-ID: <3ABC6D18.337E5089@blue-labs.org>
Date: Sat, 24 Mar 2001 01:47:04 -0800
From: David Ford <david@blue-labs.org>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: otto.wyss@bluewin.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux should better cope with power failure
In-Reply-To: <3ABB6B82.62293CAD@uni-mb.si> <3ABBA400.2AEC97E8@bluewin.ch> <3ABBD11D.FE20FB69@blue-labs.org> <3ABC5E89.FB6A2C89@bluewin.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss wrote:

> > No, the correct answer is if you want a reliable recovery then run your disks
> > in non write buffered mode.  I.e. turn on sync in fstab.
> >
> You probably haven't tried to use sync or you would have noticed the
> performace penalty. I think nobody really considers sync an alternative.
>
> O. Wyss

You can't have the best of everything.  There are tradeoffs.  A viable option is a
journaled filesystem.  Linux boasts a few, two of which are at your fingertips by
way of config options.  Read up on JFS or ReiserFS.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



