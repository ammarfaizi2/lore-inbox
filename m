Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRCAM7l>; Thu, 1 Mar 2001 07:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129576AbRCAM7b>; Thu, 1 Mar 2001 07:59:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129563AbRCAM7Y>; Thu, 1 Mar 2001 07:59:24 -0500
Date: Thu, 1 Mar 2001 07:59:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Neal Gieselman <Neal.Gieselman@Visionics.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 fsck question
In-Reply-To: <D0FA767FA2D5D31194990090279877DA57328F@dbimail.digitalbiometrics.com>
Message-ID: <Pine.LNX.3.95.1010301075344.9180A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Neal Gieselman wrote:

> I then went single user and ran fsck.ext3 on / while mounted.
> Bad move.  It ran and reported many errors which I chose to repair.
> It screwed the partition up to the point where it paniced on boot.
[SNIPPED....]

You must NEVER fsck a file-system that is mounted read/write. Note,
when you `umount /`. It is still available for read/execute. You
can execute fsck at this time.

> Anyone else have luck with this combination?
> Excuse the stupid question, but with ext3, do I really require the
> fsck.ext3?  

fsck.ext3 goes with ext3 file systems, just like fsck.ext2 goes with
ext2. 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


