Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270561AbTGNHap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270562AbTGNHap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:30:45 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:31908 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S270561AbTGNHao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:30:44 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16146.24474.707720.580442@laputa.namesys.com>
Date: Mon, 14 Jul 2003 11:45:30 +0400
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: utimes/futimes/lutimes syscalls
In-Reply-To: <20030711224210.6fee6a73.akpm@osdl.org>
References: <3F0F9B0C.10604@redhat.com>
	<20030711224210.6fee6a73.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Ulrich Drepper <drepper@redhat.com> wrote:
 > >
 > > If
 > >  there are filesystems which store the sub-seconds on disk I think this
 > >  is necessary since otherwise all kinds of programs (including archives)
 > >  cannot be written correctly.  If the sub-seconds only live in memory I
 > >  still think it would be good to have the syscalls but it would not be
 > >  that urgent.
 > 
 > XFS (at least) stores nanoseconds on disk.  So yes, I think we should make
 > this change.

so does reiser4.

 > -

Nikita.

