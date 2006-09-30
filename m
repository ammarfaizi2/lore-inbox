Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWI3GaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWI3GaG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 02:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWI3GaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 02:30:06 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:40366 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751069AbWI3GaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 02:30:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y+aG/zRRp0KZWBTOXe6N1lEFkDw6d3Qa6I9AllCV6zPBCZqQF7e1ERPhBqPDzcFWmwVZPvzZ2fQQ7WR07W746EGXXx9x0yMfswLuQSaufORanZuU3Q/ya6+YHD/LRFT4UdxzAEIhcW+0I/pU9XHsZXLav8GS6pAL/Ns3BzA0x5A=
Message-ID: <e5bfff550609292330s68f309dcodb6617e006002f61@mail.gmail.com>
Date: Sat, 30 Sep 2006 08:30:03 +0200
From: "Marco Costalba" <mcostalba@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE qgit-1.5.2] bug fix release
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly a bug fix release.

Fixes are all over the place but most important are the fixes to code
range filtering.

Code range filtering is when you select some text in file viewer and
want to view the list of revisions that modified that code range.

Download tarball from http://www.sourceforge.net/projects/qgit

or directly from git public repository
git://git.kernel.org/pub/scm/qgit/qgit.git


Please refer to http://digilander.libero.it/mcostalba/ for additional
information.

	Marco


ChangeLog from 1.5.1

- fix a memory leak in case annotation is closed while processing
- fix a rare segfault due to a race in annotation code
- fix commit when the change in working dir is a file deletion
- fix file list is not cleared when changing to revision with no files
- load file history without --topo-order option
- fix bold file content after removing range filter
- fix range filter miscalculation
- fixed two bugs in range filter code
- fix file view font to match main view one
- fix date/time column title issues
- fix a very rare hang on exit
- refactor exceptions handling code
