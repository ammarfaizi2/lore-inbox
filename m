Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSFJBBt>; Sun, 9 Jun 2002 21:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSFJBBs>; Sun, 9 Jun 2002 21:01:48 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:25361 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315762AbSFJBBr>;
	Sun, 9 Jun 2002 21:01:47 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206100101.g5A11i1480453@saturn.cs.uml.edu>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
To: nmiell@attbi.com (Nicholas Miell)
Date: Sun, 9 Jun 2002 21:01:44 -0400 (EDT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        adelton@informatics.muni.cz (Jan Pazdziora), christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <1023666358.1518.44.camel@entropy> from "Nicholas Miell" at Jun 09, 2002 04:45:57 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell writes:
> On Sun, 2002-06-09 at 15:05, Albert D. Cahalan wrote:
>> Nicholas Miell writes:

>>>> [ insane abuse of VFAT for multi-user systems ]
>>>
>>> You're not serious, right?
>>
>> I'm very serious. The ability to install without partitioning
>> is important for hesitant new users.
>>
>> Why not? The system might feel "unclean" to you, but it's
>> great for converting the Windows users. Not many people
>> are willing to trash their one-and-only partition, full of
>> data, to experiment with a new OS. Regular users don't
>> keep backups. Linux is the only UNIX-like OS that could
>> do a respectable job of running multi-user on vfat.
>
> The same thing can be (and is) done using initrd+loopback, with a lot
> less effort and all of the usual Unix filesystem semantics.

You don't get a shared filesystem that way. Windows would
not be able to see the files created by Linux. You'd get stuck
using the ext2 resizer all the time. You couldn't even move
a file from ext2 to vfat without having enough disk space for
it in both places.

