Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316777AbSFUUKe>; Fri, 21 Jun 2002 16:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316778AbSFUUKd>; Fri, 21 Jun 2002 16:10:33 -0400
Received: from holomorphy.com ([66.224.33.161]:57283 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316777AbSFUUKc>;
	Fri, 21 Jun 2002 16:10:32 -0400
Date: Fri, 21 Jun 2002 13:10:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erik McKee <camhanaich99@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUGREPORT] kernel BUG in page_alloc.c:141!
Message-ID: <20020621201003.GC22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erik McKee <camhanaich99@yahoo.com>, linux-kernel@vger.kernel.org
References: <20020621191528.86025.qmail@web14202.mail.yahoo.com> <20020621200613.GB22961@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621200613.GB22961@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 12:15:28PM -0700, Erik McKee wrote:
>> Booted 2.5.24, and it ran fine for sometime, before it dead(live) locked,
>> causing a reboot.  Attempts to reboot were met with the following bug
>> immediatly after calibrating delay loop, which equates out to an
>> if(bad_range(buddy1,zone)) BUG; in __free_pages_ok:

On Fri, Jun 21, 2002 at 01:06:13PM -0700, William Lee Irwin III wrote:
> This looks odd. Can you by any chance disassemble the parts before this?
> Or better yet, reproduce it with a kernel compiled with -g and objdump
> --source --disassemble vmlinux to get the disassembly of __free_pages_ok()?

Oh, also include the updated oops if you can. What I'll be trying to do
is figure out what variables are in which registers and stack locations
to get their values and then fish their values out of the oops.


Thanks,
Bill
