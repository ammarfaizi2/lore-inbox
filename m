Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbRFRNpk>; Mon, 18 Jun 2001 09:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbRFRNpa>; Mon, 18 Jun 2001 09:45:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3385 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263964AbRFRNpO>; Mon, 18 Jun 2001 09:45:14 -0400
Date: Mon, 18 Jun 2001 15:44:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: German Gomez Garcia <german@piraos.com>,
        Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
Message-ID: <20010618154446.B13836@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0106181500480.270-100000@hal9000.piraos.com> <Pine.LNX.4.33.0106181524580.15235-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106181524580.15235-100000@Expansa.sns.it>; from kernel@Expansa.sns.it on Mon, Jun 18, 2001 at 03:34:43PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2001 at 03:34:43PM +0200, Luigi Genoni wrote:
> Maybe there could be some HW related reason because of which it fixed for

yes, most probably he didn't had any zone empty so the fix couldn't make
a difference for him. German, can you confirm? (if you don't know what
it means just show me a SYSRQ+M and I'll find out myself :)

Since the fix didn't helped it sounds like the memory balancing in -ac
is not working properly for other reasons too.

Andrea
