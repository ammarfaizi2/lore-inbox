Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUGGEtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUGGEtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 00:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbUGGEtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 00:49:10 -0400
Received: from c66-235-4-168.sea2.cablespeed.com ([66.235.4.168]:25590 "EHLO
	darklands.zimres.net") by vger.kernel.org with ESMTP
	id S264904AbUGGEtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 00:49:08 -0400
From: qubes@darklands.zimres.net
Date: Tue, 6 Jul 2004 21:46:59 -0700
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: quite big breakthrough in the BAD network performance, which mm6 did not fix
Message-ID: <20040707044659.GA6299@darklands.zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl> <1089160973.903.1.camel@localhost> <200407061812.24526.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407061812.24526.lkml@lpbproductions.com>
X-Operating-System: Linux darklands 2.6.7-mm5
X-Operating-Status: 11:49:04 up 2 min,  2 users,  load average: 0.41, 0.20, 0.07
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Jul 06:12, Matt Heler wrote:
> Not to sound mean about this. But either you prove your claim with benchmarks 
> in a controlled enviroment ( that means in a private network ), or you stop 
> trolling and complaining. The linux kernel is a free piece of software, if 
> you don't like one version of it, then feel free to use some earlier version. 
> Otherwise please stop. 
> 
> Matt H.

I've got basicly the same problem (only worse). 2.6.7(,mm5) get 
~10 bytes/sec from seattletimes.com and 25 Kbytes/sec when I "echo 
0 > tcp_default_win_scale; \ echo 0 > tcp_moderate_rcvbuf;". This may be
open-source where you ask users to test, but asking users to setup
non-trivial HARDWARE and NETWORKS seems to be asking a bit much. YMMV, 
etc.

I'll get intrested if it doesn't fix its self by rc time.

Thomas (who could test on a "private network", but is a lazy bastard.)
