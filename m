Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283286AbRK2QDe>; Thu, 29 Nov 2001 11:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283288AbRK2QDV>; Thu, 29 Nov 2001 11:03:21 -0500
Received: from www.soccerchix.org ([64.23.60.113]:8711 "EHLO
	gib.soccerchix.org") by vger.kernel.org with ESMTP
	id <S283286AbRK2QDO>; Thu, 29 Nov 2001 11:03:14 -0500
Date: Thu, 29 Nov 2001 10:43:13 -0500 (EST)
From: Blue Lang <blue@b-side.org>
To: war war <war@starband.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <B7F1F9B7DE30EDF47ADB4F8F44CAC84B@war.starband.net>
Message-ID: <Pine.LNX.4.30.0111291039310.15947-100000@gib.soccerchix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wild guesses follow..

On Thu, 29 Nov 2001, war war wrote:

> In essence, the 'tar' command is finished, however, 30-60 seconds
> after it has finished, it is actually still decompressing the data to
> the file on the disk.

It's probably writing it from RAM to disk. 60 seconds seems like a looong
time, tho. What does iostat -x tell ya during the time when tar is
finished and the disk is still going?

> On Solaris, when I untar a file, the disk stops grinding when the tar
> process is finished, and the system is totally usuable.

You can mount your filesystem synchronously..

-- 
   Blue Lang, editor, b-side.org                     http://www.b-side.org
   2315 McMullan Circle, Raleigh, North Carolina, 27608       919 835 1540

