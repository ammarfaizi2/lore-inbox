Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTECAag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 20:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbTECAag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 20:30:36 -0400
Received: from news.cistron.nl ([62.216.30.38]:49678 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263212AbTECAaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 20:30:35 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: sendfile
Date: Sat, 3 May 2003 00:42:59 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b8v3aj$p2j$1@news.cistron.nl>
References: <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no> <20030502024147.GA523@mark.mielke.cc> <3EB1F1CD.4060702@nortelnetworks.com> <20030502210648.GA5322@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1051922579 25683 62.216.29.200 (3 May 2003 00:42:59 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030502210648.GA5322@mark.mielke.cc>,
Mark Mielke  <mark@mark.mielke.cc> wrote:
>One question it raises in my mind, is whether there would be value in
>improving write()/send() such that they detect that the userspace
>pointer refers entirely to mmap()'d file pages, and therefore no copy
>of data from userspace -> kernelspace should be performed.

You mean like
http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week00/0056.html

Mike.

