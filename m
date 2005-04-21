Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVDUPCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVDUPCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVDUPCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:02:30 -0400
Received: from viking.sophos.com ([194.203.134.132]:38918 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261415AbVDUPC1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:02:27 -0400
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 21/04/2005 16:02:16,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 21/04/2005 16:02:16,
	Serialize complete at 21/04/2005 16:02:16,
	S/MIME Sign failed at 21/04/2005 16:02:16: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 21/04/2005 16:02:25,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 21/04/2005 16:02:25,
	Serialize complete at 21/04/2005 16:02:25,
	S/MIME Sign failed at 21/04/2005 16:02:25: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 21/04/2005 16:02:27,
	Serialize complete at 21/04/2005 16:02:27
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] properly stop devices before poweroff
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF6B451068.53D0EED6-ON80256FEA.00510AF0-80256FEA.00529EA9@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Thu, 21 Apr 2005 16:02:22 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2005 12:38:29 linux-kernel-owner wrote:

>> >Without this patch, Linux provokes emergency disk shutdowns and
>> >similar nastiness. It was in SuSE kernels for some time, IIRC.
>> OMG! And I did try to raise that issue 10 months ago, see below:
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0406.0/0242.html
>
>Heh, verify that this patch works for you and it might finally get
>fixed...

I can't "hear" the difference between normal and emergency shutdown, and 
information I found does not suggest they are recorded amongst s.m.a.r.t 
attributes. Power_Cycle_Count, Load_Cycle_Count and 
Power-Off_Retract_Count seem to be in sync, although common sense would 
suggests that the last one should possibly not increment on a clean 
shutdown. I will experiment a bit when I find some spare time.

