Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbTAINCU>; Thu, 9 Jan 2003 08:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbTAINCU>; Thu, 9 Jan 2003 08:02:20 -0500
Received: from [81.2.122.30] ([81.2.122.30]:59140 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266363AbTAINCT>;
	Thu, 9 Jan 2003 08:02:19 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301091311.h09DB4Ka001126@darkstar.example.net>
Subject: [ANNOUNCE] Kernel Bug Database V1.10 on-line
To: linux-kernel@vger.kernel.org
Date: Thu, 9 Jan 2003 13:11:04 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 1.10 of my kernel bug database is now on-line at:

http://grabjohn.com/kernelbugdatabase/

Main updates:

* Automatic account creation

No need to E-Mail a request for an account to me - there is a link to
create one if you don't have one already.

* Generate a config file with the same options as the one that was uploaded
  with the bug report.

If the original submitter of a bug uploaded their config file, you can
download a config file with the same options set.

* Patch database 

Patches can be submitted against a bug report, along with comments,
and the facility is in place to automatically test the patch to see if
it applies against any number of kernel trees.  This will probably not
be enabled until the bug database is moved on to another machine which
has more disk space for the uncompressed kernel trees.

It's also possible to browse the available patches, search for strings
in patches, and download the patches, (obviously).

* Command line interface improvements

Eventually intended to be accessible via E-Mail, you can currently
test the command line interface via the web.  I've added commands
related to patch handling.

* Minor enhancements

Various enhancements, including categorising of drop down lists of
kernel versions and config options.

* Various bugfixes

Various bugfixes and minor enhancaments to improve the bug database
overall.

Important note
========= ====

Bugs in the database are not assigned any kind of status, nor are they
assigned to one or more people, for them to work on.

This is intentional - eventually, the best way to use this database
will be like this:

* A user uploads their config file, (or an oops, or searches using
  keywords).

* No bugs are found, or only ones that are nothing to do with the bug
  the user is experiencing.

* The user submits a bug report

* That bug report is re-named, re-numbered, commented on, or even
  deleted if it is a duplicate, by developers, until eventually a
  patch is posted that fixes it.

* The original user uploads their config file, again a week later
  and gets a list of bug reports back which match certain options in
  it, which the developers have identified as causing the bugs.

* That list now includes the bug that the user is experiencing, and
  hopefully also includes a patch to fix it.

* The user downloads the patch, and can also get information about
  which new kernel versions it can be applied to, and by going back to
  the bug list, can also find out which new kernel versions the bug is
  actually fixed in.

Note that if a user's original bug report is actually a duplicate of
an existing bug in the database, the bug report can simply be deleted,
(possibly after moving comments, patches, etc, from it to the original
bug).

As long as the original user does not rely on tracking the bug report
by number, and instead searches via config options, (which can be as
easy as uploading the relevant .config file), they should still find
any applicable comments and patches that the developers have
submitted.  A list of kernels that any available patches successfully
apply to can easily be downloaded, saving even more time in cases
where a patch is made against one tree, and the user wants to apply it
to another tree, (for example, because of other bugs preventing the
latest kernel version from being usable on their machine).

Comments, flames, etc, welcome.

John.
