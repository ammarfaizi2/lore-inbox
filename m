Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTIFRJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 13:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbTIFRJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 13:09:30 -0400
Received: from pat.uio.no ([129.240.130.16]:27045 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261277AbTIFRJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 13:09:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16218.5318.401323.630346@charged.uio.no>
Date: Sat, 6 Sep 2003 13:09:26 -0400
To: Joshua Weage <weage98@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
In-Reply-To: <20030906162949.27200.qmail@web40405.mail.yahoo.com>
References: <shshe3qnbtb.fsf@charged.uio.no>
	<20030906162949.27200.qmail@web40405.mail.yahoo.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Joshua Weage <weage98@yahoo.com> writes:

     > Are there any commands that would allow me to figure out why
     > the mount has stopped working?  I've looked at nfsstat and the
     > kernel seems to have stopped sending any data to the server, or
     > it may send one packet every couple of seconds.  If I start up
     > another shell and try to do an ls on the problem filesystem,
     > the command locks up and can't be interrupted.  I think I've
     > also mounted the same filesystem in another location, on the
     > same machine, and it works fine.

Does 'dmesg' produce any clues as to what is going on?

How about tcpdump?

Cheers,
  Trond
