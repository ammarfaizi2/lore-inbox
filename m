Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSBMW6T>; Wed, 13 Feb 2002 17:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSBMW6J>; Wed, 13 Feb 2002 17:58:09 -0500
Received: from fw.aub.dk ([195.24.1.194]:37760 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S289058AbSBMW5y>;
	Wed, 13 Feb 2002 17:57:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-rc1
Date: Wed, 13 Feb 2002 23:53:41 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.21.0202131732330.20915-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0202131732330.20915-100000@freak.distro.conectiva>
X-BeenThere: crackmonkey@crackmonkey.org
X-Fnord: +++ath
X-Message-Flag: Message text blocked
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b8HV-0001JS-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 February 2002 20:33, Marcelo Tosatti wrote:
> So here it goes.
>
> rc1:
<snip>
> - Merge some -ac bugfixes			(Alan Cox)

Here's a crazy idea. Why not branch off the new pre-tree when commiting a 
rc-kernel? 
There's a number of patches in the ac-tree you proberbly already have 
commited to the next pre-kernel in your mind. The basic idea is that when you 
release a patch as release candidate, you shortly after release the first 
pre-patch for next kernel. For the release candidate there is test delay, 
such that at least 1 maybe 2 weeks has to pass without an unsolved release 
critical bug, before a release candidat can be promoted to be a stable 
version. This would for periods of time result in two patches for the stable 
tree. (yes, I am Debian user, how did you guess?)

The advantages are two fold, not only could it ease the presure to allow a 
rc-patch to stay rc for longer, it would even out the load on you as 
mainterner, as you could always accept new patches into the next pre-patch as 
there will always be one.  I.e you would only have to make decisions of 
whether this patch is critical or not for the stable release or merely 
something for the next release.
The disadvantage, might be that fewer hackers would test the rc, although 
this could even out with the longer rc-period, and that you might see an 
increase in your work-load if you both have the test the rc and maintain the 
next release tree.

Anyway, just a random thought.
Greetings
-Allan
