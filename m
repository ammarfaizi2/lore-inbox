Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbSL3Xw3>; Mon, 30 Dec 2002 18:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSL3Xw3>; Mon, 30 Dec 2002 18:52:29 -0500
Received: from [81.2.122.30] ([81.2.122.30]:2312 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267106AbSL3Xw2>;
	Mon, 30 Dec 2002 18:52:28 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212310000.gBV000hW004368@darkstar.example.net>
Subject: New kernel bug database on-line
To: linux-kernel@vger.kernel.org
Date: Mon, 30 Dec 2002 23:59:59 +0000 (GMT)
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of weeks ago, I started a thread about writing a bug database
dedicated to Linux kernel development.

My theory is that by making it Linux kernel development specific, it
can save more time, and make bug tracking easier than a generic bug
database.

Anyway, version 1.0 is now on-line:

http://grabjohn.com/kernelbugdatabase/

For the time being, you'll have to E-Mail me a request for a user
account, (which you need to do anything with it), but I've also put
some screenshots on-line here:

http://grabjohn.com/kernelbugdatabase/screenshots/

Basically, it's designed around two main principles:

* As much as possible is done automatically - you shouldn't need to
search using keywords, or categorise things manually, (although you
can).  Instead, try searching for bugs by uploading a .config file,
and having it automatically parsed, by selecting config options from a
list, or by browsing the database for the state of bugs in a
particular kernel tree.

* Bugs are colour-coded:
  Grey  - untested in this kernel version
  Blue  - untestable in this kernel version due to other bugs
  Red   - this bug is present in this kernel
  Green - this bug is not present in this kernel

There is also a command line interface, which will eventually be
accessible via E-Mail, but for the time being it is only accessible
via the web.  The command line interface currently allows you to list
the bugs, get details about them, and add comments.

Any comments on this new bug database would be very much appreciated!

John
