Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUGGPrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUGGPrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUGGPrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:47:05 -0400
Received: from warsl404pip7.highway.telekom.at ([195.3.96.91]:29757 "HELO
	email11.aon.at") by vger.kernel.org with SMTP id S264902AbUGGPrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:47:01 -0400
Message-ID: <40EC1AF3.9050002@yahoo.de>
Date: Wed, 07 Jul 2004 17:46:59 +0200
From: Wiesner Thomas <w15mail@yahoo.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.4) Gecko/20030619 Netscape/7.1 (ax)
X-Accept-Language: de-de, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Announcement of HTML-Index of linux-2.6.4/Documentation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcement of HTML-Index of linux-2.6.4/Documentation

I had some spare time and decided to make a bash script which generates
(with the help of some description files) a nice HTML Index for
linux-2.6.4/Documentation to give it a better look. (I think it would be
interesting for kernel-hq.)

I did it for 2.6.4, because I had the tarball of it on my hdd. I have a 56k
modem which doesn´t make downloading kernel source fun. (I know that 
there are
patches, but I´m too lazy.). But it should work with nearly any source 
version
(should work even "stand alone") but then you have broken links.

The package is not a patch, but a tarball, because I only needed to add 
files
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

I would be nice to get some feedback.

BTW: This is my first contribution and please CC me, as I´m not in the list.


      Wiesner Thomas

