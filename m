Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285584AbRLYQUJ>; Tue, 25 Dec 2001 11:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285654AbRLYQT7>; Tue, 25 Dec 2001 11:19:59 -0500
Received: from dialin-145-254-150-198.arcor-ip.net ([145.254.150.198]:56847
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S285584AbRLYQTu>; Tue, 25 Dec 2001 11:19:50 -0500
Message-ID: <3C28A640.9C9B8462@loewe-komp.de>
Date: Tue, 25 Dec 2001 17:16:00 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.14-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: nknight@pocketinet.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Who fixed via82cxxx_audio.c ?
In-Reply-To: <WHITExvWvqzAoa2JB1n000005b3@white.pocketinet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight schrieb:
> 
> Several months back, I started trying to get the via82cxxx_audio.c
> sound driver fixed, it was causing lockup problems whenever something
> opened and/or used the mixer. A similar route was taken as I took with
> the Athlon optimization problems, trying to get everyone to send as
> much information as possible on their cards using this driver. This
> never really led anywhere, and the only information gleaned was that
> dropping buffers down to extremely low levels helped in some cases, but
> not all, and didn't always completely fix it.
> 
> After 2.4.10 was released, I stopped updating my kernel for a variety
> of reasons (less time spent in linux, long story.) However a while back
> I updated to 2.4.16, and decided to load XMMS just for the hell of it,
> not 5 minutes ago. To my delight, the problem is completely solved. I
> checked all the changelogs from 2.4.10 to now, and the only mention I
> found searching for "97" (ac97 codec is used) and "via82" was in the
> 2.4.*17* changelog, saying Jeff was no longer the maintainer.
> I'd like to know who managed to find and fix the underlying cause, so I
> can both thank them, and find out what the heck this problem that
> plagued me for many months was.


I would check the ChangeLog of the audio driver, since the
hardware access to the ac97 mixer is done there.

--
ciao
Peter
