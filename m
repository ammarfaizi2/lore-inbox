Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285461AbRLYLUS>; Tue, 25 Dec 2001 06:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285465AbRLYLUI>; Tue, 25 Dec 2001 06:20:08 -0500
Received: from white.pocketinet.com ([12.17.167.5]:32670 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S285461AbRLYLUA>; Tue, 25 Dec 2001 06:20:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: linux-kernel@vger.kernel.org
Subject: Who fixed via82cxxx_audio.c ?
Date: Tue, 25 Dec 2001 03:20:02 -0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITExvWvqzAoa2JB1n000005b3@white.pocketinet.com>
X-OriginalArrivalTime: 25 Dec 2001 11:18:22.0306 (UTC) FILETIME=[DCF74420:01C18D35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several months back, I started trying to get the via82cxxx_audio.c 
sound driver fixed, it was causing lockup problems whenever something 
opened and/or used the mixer. A similar route was taken as I took with 
the Athlon optimization problems, trying to get everyone to send as 
much information as possible on their cards using this driver. This 
never really led anywhere, and the only information gleaned was that 
dropping buffers down to extremely low levels helped in some cases, but 
not all, and didn't always completely fix it.

After 2.4.10 was released, I stopped updating my kernel for a variety 
of reasons (less time spent in linux, long story.) However a while back 
I updated to 2.4.16, and decided to load XMMS just for the hell of it, 
not 5 minutes ago. To my delight, the problem is completely solved. I 
checked all the changelogs from 2.4.10 to now, and the only mention I 
found searching for "97" (ac97 codec is used) and "via82" was in the 
2.4.*17* changelog, saying Jeff was no longer the maintainer.
I'd like to know who managed to find and fix the underlying cause, so I 
can both thank them, and find out what the heck this problem that 
plagued me for many months was.
