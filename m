Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310162AbSCKPco>; Mon, 11 Mar 2002 10:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310163AbSCKPcZ>; Mon, 11 Mar 2002 10:32:25 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:15031 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S310162AbSCKPcP>; Mon, 11 Mar 2002 10:32:15 -0500
Message-Id: <200203111444.HAA11416@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Hans Reiser <reiser@namesys.com>, "Mark H. Wood" <mwood@IUPUI.Edu>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Mon, 11 Mar 2002 08:29:56 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu> <3C8C95D8.2070601@namesys.com>
In-Reply-To: <3C8C95D8.2070601@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 March 2002 04:32 am, Hans Reiser wrote:
> Mark H. Wood wrote:
> >On Sun, 10 Mar 2002, Itai Nahshon wrote:
> >>On Sunday 10 March 2002 10:36, Hans Reiser wrote:
> >>>I think that if version control becomes as simple as turning on a plugin
> >>>for a directory or file, and then adding a little to the end of a
> >>>filename to see and list the old versions, Mom can use it.
> >>
> >>IIRC that was a feature in systems from DEC even before
> >>VMS (I'm talking about the late 70's).  eg. file.txt;2 was revision 2
> >>of file.txt.
> >>
> >>I don't know if this feature was in the file-system or in the text editor
> >>that I have used.
> >
> >It's part of the TOPS-20 filesystem.  If you try to create a file which
> >already exists, you get a new version of the file with length zero.  Each
> >file has a version limit in its directory entry, and when the limit is
> >exceeded the oldest version is automagically deleted.  The version limit
> >is copied from the highest existing version to the new version, and the
> >limit on the highest version determines whether old versions are dropped.
>
> If it isn't optional (on per file and/or per directory basis) for users,
> it would be quite annoying.
>
> Hans

Quoting from "VMS General User's Manual", section 2.1.1 Filenames, Types,
and Versions, "You can control the number of versions of a file by specifying 
the /VERSION_LIMIT qualifier to the DCL commands CREATE/DIRECTORY, SET DIRECTORY, 
and SET FILE."

It has been a while (about 12 years), but IIRC, you could set /VERSION_LIMIT=1 and
effectively get rid of the annoying versions.  But some people, the Aunt Tillie
types, were always tripping over their shoelaces and unintentially deleting files.
For those people, the version feature probably seemed a blessing rather than a
curse.

Steven
