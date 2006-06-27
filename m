Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWF0TVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWF0TVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWF0TVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:21:37 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:35985 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030294AbWF0TVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:21:35 -0400
From: David Brownell <david-b@pacbell.net>
To: Jes Sorensen <jes@sgi.com>, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [patch] fix static linking of NFS
Date: Tue, 27 Jun 2006 12:21:31 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <yq04py7j699.fsf@jaguar.mkp.net> <1151426697.23773.10.camel@lade.trondhjem.org> <44A1809F.5030306@sgi.com>
In-Reply-To: <44A1809F.5030306@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606271221.31927.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK here's a version of my patch that I edited to remove the
comments Jes objected to ... /* init or exit */ to remind
about the omitted section annotation.  Having one of those
would save multiple kbytes throughout the kernel, and I had
include the comments as reminders for an eventual fix...

- Dave
