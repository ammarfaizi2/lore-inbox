Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUFFPY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUFFPY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 11:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUFFPY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 11:24:59 -0400
Received: from [198.95.226.53] ([198.95.226.53]:63931 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S263001AbUFFPY5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 11:24:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: Killing POSIX deadlock detection
Date: Sun, 6 Jun 2004 08:24:24 -0700
Message-ID: <482A3FA0050D21419C269D13989C61130435E200@lavender-fe.eng.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Killing POSIX deadlock detection
Thread-Index: AcRLyht/oWKQZLK+Q5OCX1MHH3QKhQAD8IWw
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Matthew Wilcox" <willy@debian.org>,
       "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: <trond.myklebust@fys.uio.no>, <akpm@osdl.org>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, final call.  Any objections to never returning -EDEADLCK?

not an objection, but a consideration.

is this a change that belongs in 2.6?  it does significantly change the
behavior of the system call API, and could "break" applications.

unless this fixes a significant bug, perhaps it should wait for 2.7?
that would give fair warning to developers who need to fix their broken
programs.
