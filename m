Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUGDJkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUGDJkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 05:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUGDJkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 05:40:23 -0400
Received: from web51903.mail.yahoo.com ([206.190.39.46]:29285 "HELO
	web51903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265487AbUGDJkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 05:40:19 -0400
Message-ID: <20040704094019.32056.qmail@web51903.mail.yahoo.com>
Date: Sun, 4 Jul 2004 11:40:19 +0200 (CEST)
From: =?iso-8859-1?q?Wiesner=20Thomas?= <w15mail@yahoo.de>
Subject: Announcement of HTML-Index of linux-2.6.4/Documentation
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had some spare time and decided to make a bash script which generates
(with the help of some description files) a nice HTML Index for
linux-2.6.4/Documentation to give it a better look. (I think it would be
interesting for kernel-hq.)

I did it for 2.6.4, because I had the tarball of it on my hdd. I have a 56k
modem which doesn´t make downloading kernel source fun. (I know that there are
patches, but I´m too lazy.). But it should work with nearly any source version
(should work even "stand alone") but then you have broken links.

The package is not a patch, but a tarball, because I only needed to add files
and not to change any existing.

You can get the tarball at:
  http://members.aon.at/gwiesner/misc/2_6-html-doc-index.tar.gz

Install it by typing:
  cd /usr/src/linux-2.6.4   # or whatever dir
  cd Documentation
  tar -xzf 2_6-html-doc-index.tar.gz

To generate the HTML files run:
  ./mkhtmlindex.sh

The script will generate a index.html in Documentation
and a index.html in every subdirectory of it. (not recursive, only 1 level)

The descriptions of the files are in the files.desc and dirs.desc files.

I would be glad to hear some feedback.

BTW: This is my first contribution and please CC me, as I´m not in the list.


     Wiesner Thomas


	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
