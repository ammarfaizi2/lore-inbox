Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbQLMFAc>; Wed, 13 Dec 2000 00:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130887AbQLMFAV>; Wed, 13 Dec 2000 00:00:21 -0500
Received: from www.wen-online.de ([212.223.88.39]:39952 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130779AbQLMFAJ>;
	Wed, 13 Dec 2000 00:00:09 -0500
Date: Wed, 13 Dec 2000 05:29:33 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rainer Mager <rmager@vgkk.com>
cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: Signal 11 - the continuing saga
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGKEAKCJAA.rmager@vgkk.com>
Message-ID: <Pine.Linu.4.10.10012130518150.948-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Rainer Mager wrote:

> Thanks for the info...
> 
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Jeff V. Merkey
> > > 	So, is this related to the larger signal 11 problems?
> >
> > There's a corruption bug in the page cache somewhere, and it's 100%
> > reproducable.  Finding it will be tough....
> 
> Ok, granted this will be tough but is anyone even actively working on it?
> What can I do to help?

If you want, I can extract IKD.. which happens to have a trap in place
for this (because I have a 100% reproducable swap related SIGSEGV that
I'm trying to figure out). 

If you're interested, let me know and I'll extract it (quite large) and
send it along instructions on how to do the trap.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
