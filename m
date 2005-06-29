Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVF2Cnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVF2Cnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVF2Cni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 22:43:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53130 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262286AbVF2Ckv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 22:40:51 -0400
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
References: <3174569B9743D511922F00A0C94314230AF9718E@TYANWEB>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Jun 2005 20:40:22 -0600
In-Reply-To: <3174569B9743D511922F00A0C94314230AF9718E@TYANWEB> (YhLu@tyan.com's
 message of "Fri, 24 Jun 2005 16:47:05 -0700")
Message-ID: <m1fyv13my1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YhLu <YhLu@tyan.com> writes:

> start from 2.6.12.rc5.

A couple more tidbits of information on this problem.

1) I have seen this on two different boards
a Tyan S4882 and a Arima HDAMA, with and without linuxbios.
In just messing around adding "debug" on the kernel command line
or changing Dprintk in smpboot.c:smp_callin() to printk,
avoids this boot lock up for me.

Eric
