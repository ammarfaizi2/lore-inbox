Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVA0DI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVA0DI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVAZXLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:11:49 -0500
Received: from mail.joq.us ([67.65.12.105]:36315 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262409AbVAZQjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:39:32 -0500
To: hihone@bigpond.net.au
Cc: Ingo Molnar <mingo@elte.hu>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: [ck] [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au>
	<20050126100846.GB8720@elte.hu> <41F7C2CA.2080107@bigpond.net.au>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 26 Jan 2005 10:41:14 -0600
In-Reply-To: <41F7C2CA.2080107@bigpond.net.au> (Cal's message of "Thu, 27
 Jan 2005 03:18:18 +1100")
Message-ID: <87acqwnnx1.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal <hihone@bigpond.net.au> writes:

> Consideringthe amount and rate of work in progress, this may well be
> no longer be pertinent, but I'm consistently getting an oops running
> the basic jack_test3.2 with rt-limit-2.6.11-rc2-D7 on SMP (P3 993 x
> 2). The oops and jacktest log are at
>   <http://www.graggrag.com/20050127-oops/>.

I notice that JACK's call to mlockall() is failing.  This is one
difference between your system and mine (plus, my machine is UP).  

As an experiment, you might try testing with `ulimit -l unlimited'.
-- 
  joq

