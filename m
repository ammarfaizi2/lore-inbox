Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSFJB62>; Sun, 9 Jun 2002 21:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSFJB62>; Sun, 9 Jun 2002 21:58:28 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:8466 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316135AbSFJB61>;
	Sun, 9 Jun 2002 21:58:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206100158.g5A1wMk522000@saturn.cs.uml.edu>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
To: nmiell@attbi.com (Nicholas Miell)
Date: Sun, 9 Jun 2002 21:58:22 -0400 (EDT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        adelton@informatics.muni.cz (Jan Pazdziora), christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <1023673633.1659.48.camel@entropy> from "Nicholas Miell" at Jun 09, 2002 06:47:11 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell writes:
> On Sun, 2002-06-09 at 18:01, Albert D. Cahalan wrote:

>> You don't get a shared filesystem that way. Windows would
>> not be able to see the files created by Linux. You'd get stuck
>> using the ext2 resizer all the time. You couldn't even move
>> a file from ext2 to vfat without having enough disk space for
>> it in both places.
>
> That's not any different than having seperate VFAT and ext2
> partitions in a standard dual-boot situation.

Sure. That obviously sucks; Linux can do better.
It's important to make a transition to Linux as
painless as possible. Nobody considering an OS
change likes the feeling that their data files
are trapped on one side or the other.

I remember the screams when umsdos support was
dropped from most distributions. It would be
great to have a modern substitute for umsdos.
FAT32, NTFS, and HFS+ are what people get with
their hardware.


