Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUGMCzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUGMCzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUGMCzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:55:16 -0400
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:24747 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262450AbUGMCzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:55:12 -0400
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca>
Message-ID: <cone.1089687290.911943.12958.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org
Subject: Re: Preempt Threshold Measurements
Date: Tue, 13 Jul 2004 12:54:50 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Devenyi writes:

> Well I'm not particularly educated in kernel internals yet, here's some 
> reports from the system when its running.
> 
> 6ms non-preemptible critical section violated 4 ms preempt threshold starting 
> at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140

Certainly the do_munmap and exit_mmap seem to be repeat offenders on my 
machine too (more the latter in my case).

Con.
