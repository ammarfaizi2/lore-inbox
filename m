Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbTAJWuN>; Fri, 10 Jan 2003 17:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbTAJWuN>; Fri, 10 Jan 2003 17:50:13 -0500
Received: from holomorphy.com ([66.224.33.161]:17308 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266514AbTAJWuM>;
	Fri, 10 Jan 2003 17:50:12 -0500
Date: Fri, 10 Jan 2003 14:58:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anthony Lau <anthony@greyweasel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops with HIMEM+VM in 2.4.19,20
Message-ID: <20030110225835.GC1147@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anthony Lau <anthony@greyweasel.com>, linux-kernel@vger.kernel.org
References: <20030110083714.GA702@kimagure> <20030110104827.GM23814@holomorphy.com> <20030110180953.GB1292@kimagure>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110180953.GB1292@kimagure>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 02:48:27AM -0800, William Lee Irwin III wrote:
>> Looks like someone e.g. invalidate_inode_pages(), truncate_inode_pages(),
>> etc. etc., left pages hanging around. Borderline VM/vfs stuff. Or swap
>> code mangled something important. This oops either has buttloads of
>> stack noise or some other issue corrupting it. Can you find the first
>> oops? If this is not the first oops, then it's probably not useful.

On Fri, Jan 10, 2003 at 10:09:53AM -0800, Anthony Lau wrote:
> That was the first Oops message logged. System instability starts before
> any oop messages begin to show up in the standard syslogd logs. Something
> does appear in ksymoops. I have setup "klogd -x" and await the next log.

Okay, what filesystem(s) are you using (this usually has something to do
with a filesystem)?

Also, are you applying any patches to 2.4.19/2.4.20?



Thanks,
Bill
