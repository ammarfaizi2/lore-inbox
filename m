Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280074AbRKITfJ>; Fri, 9 Nov 2001 14:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280064AbRKITfA>; Fri, 9 Nov 2001 14:35:00 -0500
Received: from Campbell.cwx.net ([216.17.176.12]:772 "EHLO campbell.cwx.net")
	by vger.kernel.org with ESMTP id <S280070AbRKITeq>;
	Fri, 9 Nov 2001 14:34:46 -0500
Date: Fri, 9 Nov 2001 12:34:43 -0700
From: Allen Campbell <lkml@campbell.cwx.net>
To: paulh@ucentric.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: The page cache keeps growing
Message-ID: <20011109123443.A94850@const.>
In-Reply-To: <3BEC39E6.7F0FA75F@ucentric.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BEC39E6.7F0FA75F@ucentric.com>; from paulh@ucentric.com on Fri, Nov 09, 2001 at 03:17:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 03:17:42PM -0500, paulh@ucentric.com wrote:
> I'd like to throw this out to the group for opinions-
> 
> I'm working on a box using the 2.4.9 kernel that is saving a couple of
> mpeg2
> video streams, while playing back one of them.  The box also allows one
> to
> web browse, play mp3's and configure one's home network.
> 
> What I'm seeing is the page cache grow to huge sizes- to as much as
> 102MB
> of 128MB of memory.  This is causing pages to be stolen from other
> processes
> in memory, so that when a user attempts to go to one of these, a long
> wait ensues
> while it's paged back in.

Move on to 2.4.14.  VM changes since 2.4.9 have been 'significant.'

-- 
  Allen Campbell       |  Lurking at the bottom of the
  allenc@verinet.com   |   gravity well, getting old.
