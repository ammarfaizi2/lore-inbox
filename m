Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUDWUoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUDWUoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUDWUoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:44:11 -0400
Received: from main.gmane.org ([80.91.224.249]:25814 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261418AbUDWUoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:44:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: File system compression, not at the block layer
Date: Fri, 23 Apr 2004 22:44:30 +0200
Message-ID: <yw1xoepio24x.fsf@kth.se>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-1832.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:wwvBdnfDzNlul3ERkwBQkKCxUlg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On Fri, 23 Apr 2004, Joel Jaeggli wrote:
>
>> On Fri, 23 Apr 2004, Paul Jackson wrote:
>>
>> > > SO... in addition to the brilliance of AS, is there anything else that
>> > > can be done (using compression or something else) which could aid in
>> > > reducing seek time?
>> >
>> > Buy more disks and only use a small portion of each for all but the
>> > most infrequently accessed data.
>>
>> faster drives. The biggest disks at this point are far slower that the
>> fastest... the average read service time on a maxtor atlas 15k is like
>> 5.7ms on 250GB western digital sata, 14.1ms, so that more than twice as
>> many reads can be executed on the fastest disks you can buy now... of
>> course then you pay for it in cost, heat, density, and controller costs.
>> everthing is a tradeoff though.
>>
>
> If you want to have fast disks, then you should do what I
> suggested to Digital 20 years ago when they had ST-506
> interfaces and SCSI was available only from third-parties.
> It was called "striping" (I'm serious!). Not the so-called
> RAID crap that took the original idea and destroyed it.
> If you have 32-bits, you design an interface board for 32
> disks. The interface board strips each bit to the data that
> each disk gets. That makes the whole array 32 times faster
> than a single drive and, of course, 32 times larger.

For best performance, the spindles should be synchronized too.  This
might be tricky with disks not intended for such operation, of course.

-- 
Måns Rullgård
mru@kth.se

