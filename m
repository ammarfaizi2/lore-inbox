Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSGTTA7>; Sat, 20 Jul 2002 15:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSGTTA7>; Sat, 20 Jul 2002 15:00:59 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:12764 "EHLO
	pimout2-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S317463AbSGTTA6>; Sat, 20 Jul 2002 15:00:58 -0400
Message-Id: <200207201904.g6KJ434325356@pimout2-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: What does the "i" in inode stand for?  Dennis Ritchie doesn't know either.
Date: Sat, 20 Jul 2002 09:05:42 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis Ritchie hath replied, unto the masses, with a resounding "dunno" from on high...

----------  Forwarded Message  ----------

Subject: Re: What does the "i" in inode stand for?  Nobody seems to know...
Date: Sat, 20 Jul 2002 00:52:39 -0400
From: Dennis Ritchie <dmr@plan9.bell-labs.com>
To: landley@trommello.org

In truth, I don't know either.  It was just a term
that we started to use.  "Index" is my best guess,
because of the slightly unusua file systeml structure
that stored the access information of files as a flat array on
the disk, with all the hierarchical directory information living
aside from this. Thus the the i-number is an
index in this array, the i-node is the selected element
of the array.  (The "i-" notation was used in the
1st edition manual; its hyphen became gradually
dropped).

	Dennis

Received: from scummy.research.bell-labs.com ([135.104.2.10]) by plan9; Fri Jul 19 01:37:05 EDT 2002
Received: from scummy.research.bell-labs.com (localhost [127.0.0.1])
	by scummy.research.bell-labs.com (8.11.6/8.11.6) with ESMTP id g6J5aik93810
	for <dmr@plan9.bell-labs.com>; Fri, 19 Jul 2002 01:36:44 -0400 (EDT)
Received: from dusty.research.bell-labs.com (dusty.research.bell-labs.com [135.104.2.7])
	by scummy.research.bell-labs.com (8.11.6/8.11.6) with SMTP id g6J5agk93799
	for <dmr@bell-labs.com>; Fri, 19 Jul 2002 01:36:42 -0400 (EDT)
Received: from pimout3-int.prodigy.net ([207.115.63.102]) by dusty; Fri Jul 19 01:36:37 EDT 2002
Received: from there (adsl-66-136-201-37.dsl.austtx.swbell.net [66.136.201.37])
	by pimout3-int.prodigy.net (8.11.0/8.11.0) with SMTP id g6J5ada198782
	for <dmr@bell-labs.com>; Fri, 19 Jul 2002 01:36:39 -0400
Message-Id: <200207190536.g6J5ada198782@pimout3-int.prodigy.net>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Rob Landley <landley@trommello.org>
To: dmr@bell-labs.com
Subject: What does the "i" in inode stand for?  Nobody seems to know...
Date: Thu, 18 Jul 2002 19:38:19 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
I asked on the linux-kernel mailing list, and got four different replies.
The votes so far are "information", "index", "incore", and "indirection",
with more coming in...

Care to clear up this mystery for the younger generation? :)

Rob

-------------------------------------------------------


