Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTAJSBK>; Fri, 10 Jan 2003 13:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTAJSBK>; Fri, 10 Jan 2003 13:01:10 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:50092 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265275AbTAJSBJ>; Fri, 10 Jan 2003 13:01:09 -0500
Date: Fri, 10 Jan 2003 10:09:53 -0800
From: Anthony Lau <anthony@greyweasel.com>
Subject: Re: Kernel Oops with HIMEM+VM in 2.4.19,20
In-reply-to: <20030110104827.GM23814@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Message-id: <20030110180953.GB1292@kimagure>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030110083714.GA702@kimagure>
 <20030110104827.GM23814@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 02:48:27AM -0800, William Lee Irwin III wrote:

Hello,

> On Fri, Jan 10, 2003 at 12:37:14AM -0800, Anthony Lau wrote:
> > 1.5GB physical RAM (MemTest86 run for 2 times, no errors)
> > 2.0GB VM on a partition
> > Aopen AX34u with Via Apollo Pro 133T chipset
> 
> Hmm, I'd call the "VM on a partition" something like "swap" myself.

It was getting a bit late in the evening for me.  =)

> Looks like someone e.g. invalidate_inode_pages(), truncate_inode_pages(),
> etc. etc., left pages hanging around. Borderline VM/vfs stuff. Or swap
> code mangled something important. This oops either has buttloads of
> stack noise or some other issue corrupting it. Can you find the first
> oops? If this is not the first oops, then it's probably not useful.

That was the first Oops message logged. System instability starts before
any oop messages begin to show up in the standard syslogd logs. Something
does appear in ksymoops. I have setup "klogd -x" and await the next log.

--
Anthony
