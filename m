Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTETMWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 08:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTETMWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 08:22:01 -0400
Received: from pat.uio.no ([129.240.130.16]:58754 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263717AbTETMWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 08:22:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16074.8425.323094.725225@charged.uio.no>
Date: Tue, 20 May 2003 14:34:49 +0200
To: Vladimir Serov <vserov@infratel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
In-Reply-To: <3ECA1A66.7090404@infratel.com>
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<3E79EAA8.4000907@infratel.com>
	<15993.60520.439204.267818@charged.uio.no>
	<3E7ADBFD.4060202@infratel.com>
	<shsof45nf58.fsf@charged.uio.no>
	<3E7B0051.8060603@infratel.com>
	<15995.578.341176.325238@charged.uio.no>
	<3E7B10DF.5070005@infratel.com>
	<15995.5996.446164.746224@charged.uio.no>
	<3E7B1DF9.2090401@infratel.com>
	<15995.10797.983569.410234@charged.uio.no>
	<3EC8DA1B.50304@infratel.com>
	<shsel2uqsh0.fsf@charged.uio.no>
	<3ECA1A66.7090404@infratel.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Vladimir Serov <vserov@infratel.com> writes:

     > Yes I do, Trond.  It doesn't help, and probably shouldn't,
     > because it's UP not SMP system.

Then I haven't a clue as to why the PPC case should differ from the
normal i386 case.

Have you been able to capture a trace of the __rpc_wake_up_task() call
that fails? So far I've only seen traces of what happens afterwards.

Cheers,
  Trond
