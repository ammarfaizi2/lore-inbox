Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUIDVCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUIDVCo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUIDVCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:02:44 -0400
Received: from launch.server101.com ([216.218.196.178]:47803 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S266127AbUIDVCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:02:41 -0400
From: Tim Fairchild <tim@bcs4me.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: NVIDIA Driver 1.0-6111 fix
Date: Sun, 5 Sep 2004 07:02:27 +1000
User-Agent: KMail/1.6.1
Cc: Christoph Hellwig <hch@infradead.org>, Sid Boyce <sboyce@blueyonder.co.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <41390988.2010503@blueyonder.co.uk> <200409041954.05272.tim@bcs4me.com> <1094327788.6575.209.camel@krustophenia.net>
In-Reply-To: <1094327788.6575.209.camel@krustophenia.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409050702.29007.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 Sep 2004 05:56, you wrote:
> On Sat, 2004-09-04 at 05:54, Tim Fairchild wrote:
> > The nvidia module compiles fine with the non mm kernel but will
> > not compile with the mm patches for me.
>
> The nvidia module is binary-only.  You are not compiling it, AIUI the
> installer fetches the binary module from the nvidia site and builds some
> wrappers.  Even if this process were to succeed the result would almost
> certainly not work.  This is the reason you need open source software.

Well, sure, there is a binary part, but there is also a source module which 
compiled fine and ran well once I found how to patch it for the mm kernels. I 
only wanted to do this for some testing and now gone back to a more standard 
2.6.9 snapshot which works fine with the default nvidia driver without 
patching (still must compile of course).

> Judging from all the tainted-kernel OOPS'es that get posted here, it
> would appear that the majority of Linux users are perfectly willing to
> buy hardware that requires binary-only drivers.  People do not seem to
> understand that there is absolutely NO incentive for vendors to open
> their source if you would buy it just the same with a binary driver!

Users are in a difficult area here. They just want a working system and the 
nvidia binary driver (for example) is easy to install and works very well. 
You simply run a shell script which will either download a kernel module to 
suit or compile a module to suit, and load the binary portion. When there is 
a major change, as in the move to 2.6 kernel, then we might need a new binary 
driver from nvidia. Even fairly clueless users can be walked through the 
nvidia driver installation.

I know the binary driver does not sit well with all and I fully understand 
that, but users just want 3D support (and better 2D) and the nvidia binary 
driver does that for them and generally the support is quite good in 
producing up to date drivers. linux is really a bit screwed without this at 
the moment as far as users who want 3D on cheap accessable nvidia hardware 
goes... Users don't really care about open and closed source. They just want 
to play quake 3 (etc).

And with the competition still hot in the video market I don't see nvidia or 
ati openning up too much, tho I would think the real secrets were in the 
hardware and firmware and not the silly little driver software - but hey, 
these guys are in a cut throat business so I guess they feel they are just 
trying to survive as many before them have not.

I've never had an oops that was specifically caused by the nvidia module, tho 
I suppose it does happen. Generally when I get an oops I remove the driver 
and recreate the situation with an untainted kernel.

tim
