Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbSKDSEx>; Mon, 4 Nov 2002 13:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSKDSEw>; Mon, 4 Nov 2002 13:04:52 -0500
Received: from [12.161.69.65] ([12.161.69.65]:49829 "EHLO
	osismtp.origin.ea.com") by vger.kernel.org with ESMTP
	id <S262434AbSKDSEu>; Mon, 4 Nov 2002 13:04:50 -0500
Subject: Need assistance in determining memory usage
From: Thomas Schenk <tschenk@origin.ea.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 12:11:07 -0600
Message-Id: <1036433472.2884.42.camel@shire>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all.

I have been asked a question by some of the developers in my
organization and after searching Google, scouring the Linux newsgroups,
and searching as many mailing list archives and howtos as I could find,
I still cannot find a satisfactory answer to the following question:

Q. How can you determine how much memory a process is using at a given
point in time?  Specifically, I want to know of a method or tool that
will tell me how much total memory a process is using, how much of that
total is shared with other processes, how much is resident, and how much
is swapped out.

Please don't say to just use ps or top, because if either of these tools
was adequate, I wouldn't be asking here and every reference I could find
indicates that this is not a trivial problem.  There were also
indications I found while searching that these tools do not always
report memory numbers accurately.  If there is a way to determine this
information using /proc, this would be ideal, since I could then
conceivably create a script or simple program that could determine the
answer given the process ID, which is what the developers here really
want.

If you can assist me in determining the answer to this question, I would
greatly appreciate it.  Please note that I am far from being a kernel
expert (being just a lowly systems administrator), so please keep make
your explanations as detailed as possible.

Tom S.

-- 
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
| Tom Schenk      | A positive attitude may not solve all your    |
| Online Ops      | problems, but it will annoy enough people to  |
| tschenk@ea.com  | make it worth the effort. -- Herm Albright    |
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

