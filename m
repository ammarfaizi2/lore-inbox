Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317686AbSGaPSp>; Wed, 31 Jul 2002 11:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSGaPSo>; Wed, 31 Jul 2002 11:18:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63662 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S317686AbSGaPSl>;
	Wed, 31 Jul 2002 11:18:41 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Jfs-discussion] Re: Testing of filesystems
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF5CB62C2E.2FD15638-ON85256C07.0053C37D@pok.ibm.com>
From: "James Inman" <jayinman@us.ibm.com>
Date: Wed, 31 Jul 2002 10:19:58 -0500
X-MIMETrack: Serialize by Router on D01ML063/01/M/IBM(Release 5.0.10 |March 28, 2002) at
 07/31/2002 11:20:02 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a link to a list of tools we use to perform stress,system, and
integration testing on JFS and EVMS, among other things.  We have used
these tools to test every JFS build that has dropped for the past 1.5
years.  I'll be happy to answer any questions you may have about our tools
and methods.

http://ltp.sourceforge.net/tooltable.php

Jay Inman
Linux Test Project
IBM Linux Technology Center
Tie Line: 678-9277   External: 512-838-9277
http://ltp.sourceforge.net
"Outside a dog, a book is man's best friend.  And inside a dog, its too
dark to read."  - Groucho Marx


Roy Sigurd Karlsbakk <roy@karlsbakk.net>@www-124.southbury.usf.ibm.com on
07/30/2002 07:30:33 AM

Sent by:    jfs-discussion-admin@www-124.southbury.usf.ibm.com


To:    "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
cc:
Subject:    [Jfs-discussion] Re: Testing of filesystems




What sort of tools _have_ been used to test JFS to date? and - what
version(s)
have been tested?

On Tuesday 30 July 2002 14:22, Bill Rugolsky Jr. wrote:
> On Tue, Jul 30, 2002 at 11:49:02AM +0200, Axel Siebenwirth wrote:
> > I wonder what a good way is to stress test my JFS filesystem. Is there
a
> > tool that does something like that maybe? Dont't want performance
> > testing, just all kinds of stress testing to see how the filesystem
"is"
> > and to check integrity and functionality.
>
> See the ext3 cvs tree at
>
>    http://sourceforge.net/projects/gkernel
>
> [Jeff Garzik's CVS tree hosts the ext3 tree.]
>
> Andrew Morton, being conscientious and methodical, has written lots of
> filesystem testing tools during his work on ext3.  Some of these tests
> are for specific ext3 regressions, but many are useful as general
> integrity tests oriented toward journalled filesystems.  He has also
> ported/improved several other tools, including a bunch of changes to
> the notorious FSX, the File System eXerciser.
>
> The Namesys folks also have a test suite for Reiserfs, see
www.namesys.com.
>
> Regards,
>
>    Bill Rugolsky
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

_______________________________________________
Jfs-discussion mailing list
Jfs-discussion@www-124.ibm.com
http://www-124.ibm.com/developerworks/oss/mailman/listinfo/jfs-discussion




