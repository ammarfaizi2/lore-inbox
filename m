Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947148AbWKKIG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947148AbWKKIG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 03:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947149AbWKKIG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 03:06:56 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:23909 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1947147AbWKKIGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 03:06:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c8zkq7L9Ve860kWWa5BR6YWMM1H4sdgbajYst608ooYwS1iw7KFU8aLir2H+zWGbmdliXzKWCIcBOeMJ8GfDtvlfl7E7xaBth/X5eH8lHeQo0MNAdM/Tc/Bq0Obn2D/DevY72MNr3BvoosoP5XMuwf5ZW1rsuKBav57lc13ALpo=
Message-ID: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>
Date: Sat, 11 Nov 2006 09:06:20 +0100
From: "Marco Costalba" <mcostalba@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] qgit-1.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

qgit it's a graphical git repositories viewer built on Qt libraries.

This is mostly a bug fix release.

Several issues has been fixed, also some crash bugs, so an update is
strongly suggested.

To note is the new possibility to set the font used by patch and file
content viewers.

Thanks to Pavel Roskin and Josef Weidendorfer for their help and patches.


Download tarball from http://www.sourceforge.net/projects/qgit
or directly from git public repository
git://git.kernel.org/pub/scm/qgit/qgit.git

Please refer to http://digilander.libero.it/mcostalba/ for additional
information.

	Marco


ChangeLog from 1.5.2

- use a smaller tab close button and a smaller icon (Pavel Roskin)

- fix a crash in case of repo change while in filtered view

- fix a crash due to evil static pointers

- clear all the panes if search from the toolbar doesn't find anything

- silence a Qt warning when closing a tab

- let the user to set the typewriter (fixed width) font used
  with patch and file content viewers

- fix broken StGit 'pop' command interface

- do not use "--keep" option of git-am as default

- fix issues with tag marks when changing graph size

- fix filenames cache data saving in case of bare repositories

- rewrite and simplify graph drawing code (Josef Weidendorfer)

- fix issues with file names with spaces

- adjust columns width when changing window size

- fetch file history from all trees instead of only current

- early exit update cycle when a new request arrives

- correctly order tags in start-up input range dialog

- fix patch numbering order in format patch
