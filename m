Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277895AbRJIUcp>; Tue, 9 Oct 2001 16:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277923AbRJIUcg>; Tue, 9 Oct 2001 16:32:36 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:15612 "EHLO
	blue.int.wirex.com") by vger.kernel.org with ESMTP
	id <S277895AbRJIUcb>; Tue, 9 Oct 2001 16:32:31 -0400
Date: Tue, 9 Oct 2001 13:40:50 -0700
From: Seth Arnold <sarnold@wirex.com>
To: linux-kernel@vger.kernel.org
Subject: recent -ac performance thoughts
Message-ID: <20011009134050.F1509@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I've tried several -ac kernels recently, and thought I would share my
experiences with the list, in the hopes that others may find my
experience useful.

I ran 2.4.9-ac16 for roughly ten days, with reasonable performance.
However, I could cause my X session to slow down by flipping the mouse
across the screen wildly; it would take the X server several seconds of
swapping focus among the dozen windows or so before it would settle down
the one with the mouse pointer.

I booted 2.4.10-ac10 plus Rik's eatcache patch (located at
http://www.surriel.com/patches/ -- it applied to -ac10 cleanly, even
though it was for -ac9) about 19 hours ago, and I must say it feels like
an improvement. I can no longer reproduce the poor performance in X.
Also, my xmms playlist (of 13000 songs) seems to be able to retrieve the
id3 tag information off the songs much faster and the scrolling is much
smoother -- however, the songs are all over an nfs mount.

Also, the xmms 'analyzer' plays smoothly, with only slight hiccups when
dragging around konqueror windows (in an opaque move format) -- previous
kernels, 2.4.5-pre2 and 2.4.9-ac16 would often just stop the analyzer
entirely.

In any event, I hoped this would be useful information for someone
having trouble with the -ac series -- try the eatcache patch and see if
your performance improves.

Cheers! :)

