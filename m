Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTIGBya (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 21:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTIGBya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 21:54:30 -0400
Received: from pat.uio.no ([129.240.130.16]:25770 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261826AbTIGBy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 21:54:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16218.36812.336689.550957@charged.uio.no>
Date: Sat, 6 Sep 2003 21:54:20 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Joshua Weage <weage98@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
In-Reply-To: <20030906231401.GB12392@mail.jlokier.co.uk>
References: <16218.5318.401323.630346@charged.uio.no>
	<20030906212250.64809.qmail@web40414.mail.yahoo.com>
	<20030906231401.GB12392@mail.jlokier.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:

     > Look for lots of retransmits from the client.  This might be
     > the bug where it adjusts the retransmit timeout to a
     > ridiculously small sub-millisecond value, because of a sequence
     > of fast cached responses from the server, then when the server
     > responds slowly due to a disk access the client times out
     > within milliseconds.  Repeatedly.

Nope. He said 2.4.18 to 2.4.20...

Cheers,
  Trond
