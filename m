Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267698AbTACW2V>; Fri, 3 Jan 2003 17:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTACW2V>; Fri, 3 Jan 2003 17:28:21 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:6371 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S267698AbTACW2U>;
	Fri, 3 Jan 2003 17:28:20 -0500
Message-ID: <3E161DFD.AB8D25AE@tin.it>
Date: Fri, 03 Jan 2003 23:34:21 +0000
From: "A.D.F." <adefacc@tin.it>
Reply-To: adefacc@tin.it
Organization: Private
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.2.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TCP Zero Copy for mmapped files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FreeBSD 5.0 should already have a zero copy for mmapped files and
IMHO it would be worth to have it in Linux 2.6 too.

It would also be very nice to be able to enable zero copy for mmapped files
by a config option.

Many applications use mapped memory to serve lots of small and
medium sized files (4 - 1024 KB) or even a few big files
(think at web servers, i.e. Apache 2, etc.);  this is done to better
serve multiple / parallel downloads being done on the same files.

Using or not using mmap() is a userland / application choice that depends
on lots of factors / strategies that are outside kernel scope.

Besides this there seems to be some work in progress to speed up
mmap() calls, thus why not doing all the work right ?

-- 
Nick Name:      A.D.F.
E-Mail:         adefacc@tin.it
E-Mail-Font:    Courier New (plain text, no html)
--
