Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWDHJoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWDHJoj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 05:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWDHJoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 05:44:38 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:30992 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751413AbWDHJoi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 05:44:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JYt/FEWEqsXmlIouNOmQNCYclpjIry/zipKnbWKm2hWxQs7jxZRsQsEV5J50SONhvpZKFl21ZiF/32jhpDD/vWDOyteY9ek8b9bP0L8EehyCbOtaoU4/VzC2cHuYrTt9oRR1a6LbkTvffnByuzdYDafPfhuqTh2Hy2bN0hQYiLA=
Message-ID: <e5bfff550604080244y40b36292ja5cfecac28e1e749@mail.gmail.com>
Date: Sat, 8 Apr 2006 11:44:37 +0200
From: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
Subject: [ANNOUNCE] qgit-1.2rc1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

qgit is a very fast git GUI viewer with a lot of features .

The biggest new feature this time is *code range filtering*

Select a file and  open the file/annotation viewer, then wait for
annotation finished and then select a history revision just to be sure
annotation info is displayed.

You will see the new 'filter' button (in annotation window tool
bar, not in main view tool bar) enabled. Press it and the file history
will be shrinked to show only revisions that modified the selected lines.

Selected code region is also highlighted for better browsing.
Filter button is a toggle button, so just press again it to release the filter.

NOTE NOTE: Range filtering it's  _slippery_   code, there are a lot of
subtle details involved, so may be something it's still missing/bogous,
qgit-1.2rc1 it's here to let properly test before final release.


DOWNLOAD

Tarball is at
http://prdownloads.sourceforge.net/qgit/qgit-1.2rc1.tar.bz2?download

Git archive is at
http://digilander.libero.it/mcostalba/scm/qgit.git

See http://digilander.libero.it/mcostalba/  for detailed download information.


INSTALLATION

To install from tarball use:

./configure
make
make install-strip

To install from git archive:

autoreconf -i
./configure
make
make install-strip

Or check the shipped README for detailed information.

CHANGELOG

 - add support for code range filtering

- much improved graph for partial repos views. Use new --boundary
git-rev-list option

- pressing ESC in startup dialog make application to quit

- add support for quick open of latest visited repositories

- add support for launching an external diff viewer

- speed-up git commands execution using usleep() in external program launcher

- highlight filter matches in revision logs

- add git version compatibility check

- fix duplicated unapplied patches in StGIT when qgit is called with
--all option

- fix run from subdirectory regression


             Marco
