Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274573AbRITRTz>; Thu, 20 Sep 2001 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274572AbRITRTp>; Thu, 20 Sep 2001 13:19:45 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:44710
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S274570AbRITRTm> convert rfc822-to-8bit; Thu, 20 Sep 2001 13:19:42 -0400
Date: Thu, 20 Sep 2001 13:19:53 -0400
From: Chris Mason <mason@suse.com>
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Andrew Morton <andrewm@uow.edu.au>
cc: Andrea Arcangeli <andrea@suse.de>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
Message-ID: <773660000.1001006393@tiny>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, September 20, 2001 07:08:25 PM +0200 Dieter Nützel
<Dieter.Nuetzel@hamburg.de> wrote:


> Please have a look at Robert Love's Linux kernel preemption patches and
> the  conversation about my reported latency results.
> 

Andrew Morton has patches that significantly improve the reiserfs latency,
looks like the last one he sent me was 2.4.7-pre9.  He and I did a bunch of
work to make sure they introduce schedules only when it was safe.

Andrew, are these still maintained or should I pull out the reiserfs bits?

-chris

