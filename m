Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVCLVPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVCLVPM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 16:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVCLVPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 16:15:12 -0500
Received: from orb.pobox.com ([207.8.226.5]:17646 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261764AbVCLVO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 16:14:57 -0500
Date: Sat, 12 Mar 2005 13:14:44 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: George Anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
Message-ID: <20050312211444.GG9796@ip68-4-98-123.oc.oc.cox.net>
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4233111A.5070807@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 07:56:10AM -0800, George Anzinger wrote:
> Yesterday's night mare, todays bug :(

Actually, I think people have been hitting this bug for a few months on
Fedora Core, so it's not really *today's* bug... This might be the first
time it's getting discussed on LKML though. (I haven't been reading LKML
closely enough to say that with 100% certainty, however.)

Summary: kernel-2.6.9-1.724_FC3 breaks APM suspend on Thinkpad
https://bugzilla.redhat.com/beta/show_bug.cgi?id=144415

-Barry K. Nathan <barryn@pobox.com>

