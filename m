Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbTDFUVc (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbTDFUVc (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:21:32 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:707 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263070AbTDFUVa (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 16:21:30 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Malcolm Beattie <mbeattie@clueful.co.uk>
Subject: Re: [PATCH] new syscall: flink
Date: Sun, 6 Apr 2003 22:33:01 +0200
User-Agent: KMail/1.5
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
References: <3E907A94.9000305@kegel.com> <200304062156.37325.oliver@neukum.org> <20030406210800.A5450@clueful.co.uk>
In-Reply-To: <20030406210800.A5450@clueful.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304062233.01357.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 6. April 2003 22:08 schrieb Malcolm Beattie:
> Oliver Neukum writes:
> > If you have an fd, the permissions based on the path are already
> > bypassed, whether you can call flink or not, aren't they?
>
> Not if it's opened O_RDONLY, for example.

OK, so you could open a file RW even if the fd you get passed
is only RO, right?

	Regards
		Oliver

