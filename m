Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUDICdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 22:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUDICdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 22:33:11 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:32176 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262389AbUDICcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 22:32:00 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: A question for the kernel 'st' coder(s)
Date: Thu, 8 Apr 2004 22:31:58 -0400
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404082231.58326.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.9.226] at Thu, 8 Apr 2004 21:31:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About 3 years ago, the backup program amanda was having a problem with 
being unable to rewind a tape drive, while mt worked just fine.

The amanda version used an ioctl call rather than a higher level 
interface.  At the time, it was fixed by using what was a non-std 
syntax according to the docs, but it worked.  My memory is getting 
faint, but it seems that 2 of the vars in the call had to be 
interchanged, or some such.  Till somewhere about the 2.6.3, maybe 
2.6.4 time frame I believe.  Now amanda seems to have lost its 
ability to rewind a tape, and must rely on the ejection and loading 
of a tape before it can read the label and verify that this is indeed 
the correct tape for this amdump run.

Was there a bit of cleanup in the st code that brought that calls 
syntax into line with the docs in moderately recent history?

Where would I find the docs on this particular call, as it exists 
today for 2.6.5+ kernels?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
