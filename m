Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUHKH23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUHKH23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 03:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267975AbUHKH23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 03:28:29 -0400
Received: from mail.broadpark.no ([217.13.4.2]:31478 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267973AbUHKH2Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 03:28:25 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <1092082920.5761.266.camel@cube>
	<cone.1092092365.461905.29067.502@pc.kolivas.org>
	<1092099669.5759.283.camel@cube> <yw1xisbrflws.fsf@kth.se>
	<1092148392.5818.6.camel@mindpipe> <yw1xllgm8quu.fsf@kth.se>
	<1092193620.784.29.camel@mindpipe>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Wed, 11 Aug 2004 09:28:27 +0200
In-Reply-To: <1092193620.784.29.camel@mindpipe> (Lee Revell's message of
 "Tue, 10 Aug 2004 23:07:01 -0400")
Message-ID: <yw1xd61y876s.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Tue, 2004-08-10 at 20:23, Måns Rullgård wrote:
>> Lee Revell <rlrevell@joe-job.com> writes:
>> 
>> > On Tue, 2004-08-10 at 04:16, Måns Rullgård wrote:
>> >> Another option would be an Alt-Sysrq-something that lowered all RT
>> >> processes to normal levels.
>> >
>> >
>> > If someone wants to code this up I and the other people on jackit-devel
>> > would gladly test it.
>> 
>> Here you go.  Some limited testing suggests that it actually works.
>> Pressing Alt-Sysrq-N (as in Nice) changes all RT tasks to SCHED_NORMAL
>> policy.
>> 
>
> I sent this patch to the jackit-devel list, and everyone seems to think
> this would be a useful feature; had this been around a few years ago it
> certainly would have aided JACK's development.

So why didn't anyone write it earlier?

> Debugging an RT process becomes as easy as a regular one (read:
> reboot free).  I see no reason not to merge it once it has been
> widely tested.

Let me know how the testing works out.

-- 
Måns Rullgård
mru@kth.se
