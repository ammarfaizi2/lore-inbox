Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbTARIHi>; Sat, 18 Jan 2003 03:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbTARIHh>; Sat, 18 Jan 2003 03:07:37 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:61153 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263491AbTARIGz>;
	Sat, 18 Jan 2003 03:06:55 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15913.3384.293703.613384@napali.hpl.hp.com>
Date: Sat, 18 Jan 2003 00:15:52 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: recent change to exit_mmap
In-Reply-To: <20030118001546.7df35e13.akpm@digeo.com>
References: <20030118060522.GE7800@krispykreme>
	<20030117224444.08c48290.akpm@digeo.com>
	<15913.1396.22808.83238@napali.hpl.hp.com>
	<20030117235317.01ad6b7b.akpm@digeo.com>
	<15913.2330.891678.16666@napali.hpl.hp.com>
	<20030118001546.7df35e13.akpm@digeo.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 18 Jan 2003 00:15:46 -0800, Andrew Morton <akpm@digeo.com> said:

  Andrew> hmm.  Seems that all the activities between the two first
  Andrew> SET_PERSONALITY() calls and the flush_old_exec() are pretty
  Andrew> innocuous.  And no mappings could be set up there, because
  Andrew> flush_old_exec() would remove them again.

That's true.  Perhaps it is just cruft.

	--david
