Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133004AbRDUWuC>; Sat, 21 Apr 2001 18:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133007AbRDUWtw>; Sat, 21 Apr 2001 18:49:52 -0400
Received: from anime.net ([63.172.78.150]:29198 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S133004AbRDUWtm>;
	Sat, 21 Apr 2001 18:49:42 -0400
Date: Sat, 21 Apr 2001 15:49:22 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Peter Makholm <peter@makholm.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Idea: Encryption plugin architecture for file-systems
In-Reply-To: <8766fyt5x3.fsf@xyzzy.adsl.dk>
Message-ID: <Pine.LNX.4.30.0104211547470.21994-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Apr 2001, Peter Makholm wrote:
> nagytam@rerecognition.com ("Tamas Nagy") writes:
> > Idea:
> > extend the current file-system with an optional plug-in system, which allows
> > for file-system level encryption instead of file-level.
> That's is one of the things the loop device offers. For better
> encryption than XOR you need the patches from kerneli.org.

I think he wants to avoid the *!!SEVERE!!* performance problems in
loopback crypto. A crypto plugin directly to filesystems would certainly
avoid most of it.

-Dan

