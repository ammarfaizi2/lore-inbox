Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272235AbRHWJB6>; Thu, 23 Aug 2001 05:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272234AbRHWJBi>; Thu, 23 Aug 2001 05:01:38 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:41622 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S272233AbRHWJBf>; Thu, 23 Aug 2001 05:01:35 -0400
Importance: Normal
Subject: Re: Allocation of sk_buffs in the kernel
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF451110AC.14EEC1A3-ONC1256AB1.0030B2FB@de.ibm.com>
From: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Date: Thu, 23 Aug 2001 11:01:42 +0200
X-MIMETrack: Serialize by Router on d12ml040/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 23/08/2001 11:01:43
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Maybe Jens should use something like WAITQUEUE_DEBUG if he want to know
> where alloc_skb and friends were called, see include/linux/wait.h 8)
Do you mean I should use something LIKE the WAITQUEUE_DEBUG (eg.
implementing something like that in skbuff.c) or I should use
WAITQUEUE_DEBUG?

The code in wait.h mainly seems to consist of issuing BUG() calls, and
thats not quite what I want to ;) But how is it to use? I don't know much
about waitqueues in the Linux kernel, I mainly played with the network
stack...

Are there any examples how to use the WAITQUEUE_DEBUG?

CU,
Jens

