Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUAUICS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 03:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUAUICS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 03:02:18 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:20717 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S262055AbUAUICQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 03:02:16 -0500
To: Brian McGroarty <brian@mcgroarty.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT370 status [2.4/2.6]
References: <1g0ZG-2q6-15@gated-at.bofh.it> <400D72B5.40705@gmx.at>
	<yw1x4quqo1gx.fsf@ford.guide> <20040120204537.GA6820@mcgroarty.net>
	<yw1xoesymilb.fsf@ford.guide> <20040121043536.GA14390@mcgroarty.net>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 21 Jan 2004 09:02:14 +0100
In-Reply-To: <20040121043536.GA14390@mcgroarty.net> (Brian McGroarty's
 message: 35:36 -0600")
Message-ID: <yw1xvfn5loft.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian McGroarty <brian@mcgroarty.net> writes:

> On Tue, Jan 20, 2004 at 10:10:56PM +0100, M?ns Rullg?rd wrote:
>> Brian McGroarty <brian@mcgroarty.net> writes:
>> 
>> > Wilfried Weissmann <Wilfried.Weissmann@gmx.at> writes:
>> >> Jan De Luyck wrote:
>> >>> Hello List,
>> >>> Before I start frying my disks and all, what's the usability status
>> >>> of the Hightpoint HPT370 ide "raid" controller on linux 2.4 and 2.6?
>> >>
>> >> 2.4 is fine if you use the ataraid code. mirroring is not fault
>> >> tolerant so you would not want to use that.
>> >
>> > No problems with 2.4 here.
>> >
>> > 2.6 recognizes my 374, which uses the hpt366 driver like the
>> > 370. However, no devices are being made available from it [1].
>> >
>> > If others' experiences are any different, I'd love to hear.
>> 
>> I've been successfully using an hpt374 based board for a year or so.
>> Right now I'm running Linux 2.6.0 (no reboot after 2.6.1 release).
>
> Can you say a bit about your configuration?
>
> - What module(s) do you load? Any parameters?

The usual bunch, i.e. USB, sound, ethernet, nfs.  Nothing specific to
the hpt374.

> - What devices do you access the hpt374 through?

Four Seagate Barracuda disks.

> - Are you running a RAID, or individual drives?

Software RAID.

> Any other info (dmesg, contents of ide procdir, etc) would be great
> for us to compare.

The evil thing just dumped a bunch of error.  I'll have to check it
out.

-- 
Måns Rullgård
mru@kth.se
