Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTIGCDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 22:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTIGCDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 22:03:30 -0400
Received: from pat.uio.no ([129.240.130.16]:61617 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263071AbTIGCCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 22:02:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16218.37312.1855.652692@charged.uio.no>
Date: Sat, 6 Sep 2003 22:02:39 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
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

     > This might be the bug where it adjusts the retransmit timeout
     > to a ridiculously small sub-millisecond value, because of a
     > sequence of fast cached responses from the server

BTW: this should be fixed now in 2.6.x. I've set a minimum value on
the estimated error on the round-trip time to 1/10sec.

Cheers,
  Trond
