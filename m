Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTJHEJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 00:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTJHEJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 00:09:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:33462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbTJHEJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 00:09:09 -0400
Date: Tue, 7 Oct 2003 21:08:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert White <rwhite@casabyte.com>
cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9? (SIGPIPE?)
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAmH7Q7NFXTUi83xFeuIJyvQEAAAAA@casabyte.com>
Message-ID: <Pine.LNX.4.44.0310072104570.32358-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Oct 2003, Robert White wrote:
>
> So I have two threads that are doing IO on a file descriptors with the
> number 5, I get an unexpected EPIPE on "5", now what?  I kept track.  Who is
> it for?

Robert. We get it. You don't like having separate file descriptors.

Fine. Don't use them. What's your point?

Why the hell do you think you have the right to say that others can't use
them? Just because you don't like them? Or just because you made a
contrieved example of SIGPIPE (which kills the process if not caught, and
is usually ignored if actually expected, since the EPIPE error return is a
lot more convenient and is thread-safe, btw)?

Feel free to continue arguing with yourself or on the mailing list, but 
please don't cc me. I'm not interested. I'm definitely "pro-choice" when 
it comes to people writing their user level applications, and I just can't 
get interested in the fact that you don't like them.

		Linus

