Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281730AbRKQMJY>; Sat, 17 Nov 2001 07:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281732AbRKQMJO>; Sat, 17 Nov 2001 07:09:14 -0500
Received: from f273.law9.hotmail.com ([64.4.8.148]:53002 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S281730AbRKQMJI>;
	Sat, 17 Nov 2001 07:09:08 -0500
X-Originating-IP: [216.41.72.60]
From: "Jeff Long" <jeffwlong@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] kernel/exit.c - zombies
Date: Sat, 17 Nov 2001 12:09:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F273FRcmVFOh1vdkmyC0001487b@hotmail.com>
X-OriginalArrivalTime: 17 Nov 2001 12:09:02.0179 (UTC) FILETIME=[A52C9330:01C16F60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.15pre5.  I start up UML 2.4.14 and see that the host
threads representing UML processes do not die when complete.  I
get an ever increasing number of [linux] lines in ps listing.
kill -9 has no effect.

Removing the kernel/exit.c patch @ line 539, this behavior goes
away.  I am running a UP kernel if that makes any difference.

This may be a dup - I didn't see my original message on the
archive.


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

