Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263512AbSITVNh>; Fri, 20 Sep 2002 17:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263527AbSITVNh>; Fri, 20 Sep 2002 17:13:37 -0400
Received: from deming-os.org ([63.229.178.1]:16907 "EHLO deming-os.org")
	by vger.kernel.org with ESMTP id <S263512AbSITVNg>;
	Fri, 20 Sep 2002 17:13:36 -0400
Message-ID: <3D8B8E5B.FBEF44B3@deming-os.org>
Date: Fri, 20 Sep 2002 14:08:43 -0700
From: Russ Lewis <spamhole-2001-07-16@deming-os.org>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: is any virtual address space reserved?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is any of a userland application's virtual address space reserved?
Certainly, some memory is used at startup: the code is loaded into some
of the virtual space, as well as the stack.  There needs to always be
enough space for the stack to grow as necessary.  But is any of the
space actually marked off as "reserved"?  If we just mmap'ed the same
file over and over again, could we fill the 4Gb address space with
identical mappings, or would we run out?

Russ

--
The Villagers are Online! villagersonline.com

.[ (the fox.(quick,brown)) jumped.over(the dog.lazy) ]
.[ (a version.of(English).(precise.more)) is(possible) ]
?[ you want.to(help(develop(it))) ]


