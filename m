Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269558AbRHCTZD>; Fri, 3 Aug 2001 15:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269568AbRHCTYx>; Fri, 3 Aug 2001 15:24:53 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:38416 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269558AbRHCTYj>; Fri, 3 Aug 2001 15:24:39 -0400
Message-ID: <3B6AFBD1.5F43B496@zip.com.au>
Date: Fri, 03 Aug 2001 12:30:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg Louis <glouis@dynamicro.on.ca>
CC: ext3-users <ext3-users@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ac4 ext3 recovery failure
In-Reply-To: <20010803082408.A800@athame.dynamicro.on.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Louis wrote:
> 
> Rebooting to try 2.4.7-ac4, I had Xfree86 crash on exit and hang the
> machine (it does that once a month or so; this notebook gets booted
> quite often).  After fscking the root and another ext2 partition, the
> system got to the big ext3 partition and just went dead.  No message,
> no disk activity, no keyboard response.  I powered down and rebooted
> 2.4.7-ac3 patched with ext3-2.4-0.9.5-247ac3, and that came up ok and
> recovered the journalled partition.

Do you think this happened during the e2fsck run, or during the
actual mount?

-
