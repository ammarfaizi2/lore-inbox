Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135775AbRDTBgL>; Thu, 19 Apr 2001 21:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135776AbRDTBgC>; Thu, 19 Apr 2001 21:36:02 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:40371 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S135775AbRDTBfq>; Thu, 19 Apr 2001 21:35:46 -0400
Message-ID: <3ADF9293.E5375BB3@kegel.com>
Date: Thu, 19 Apr 2001 18:36:19 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lewis@sistina.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [repost] Announce: Linux-OpenLVM mailing list
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sistina:

I know very little about LVM, but from watching earlier projects
in the same situation you're in now, the path you need to follow
seems clear:
   Stop using CVS internally for development.
   It makes checking in changes without submitting them to 
   Linus too easy.

To get sync'd back up, *start with the standard kernel*,
and start generating clean, human-understandable patches one 
at a time that bring it up to where you want.

Once you've achieved that, have your programmers generate patches 
rather than checking in to CVS, and feed the patches to Linus 
at the same time you hand them out to your other programmers.
Individual programmers may need to do more testing this way, but
c'est la vie.

This is the only way to achieve union with the standard kernel.

So many projects have failed to learn this lesson...
ignore it at your peril.
- Dan
