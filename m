Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269905AbRHMGx4>; Mon, 13 Aug 2001 02:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269909AbRHMGxq>; Mon, 13 Aug 2001 02:53:46 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:9175 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S269905AbRHMGxf>; Mon, 13 Aug 2001 02:53:35 -0400
Importance: Normal
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
To: Andrew Morton <akpm@zip.com.au>
Cc: Tom Rini <trini@kernel.crashing.org>, ext3-users@redhat.com,
        linux-kernel@vger.kernel.org, "Carsten Otte" <COTTE@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF03995604.DB16D72B-ONC1256AA7.00251C32@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Mon, 13 Aug 2001 08:53:30 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 13/08/2001 08:53:30
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> If it's possible, could you please also test journalled data mode?
It will take a while, but it is already planned.

> It'd be interesting to sanity test recovery as well, but doing
> thorough testing of recovery is hard.  That's why the ext3 patch
> places interesting debug/devel code way down inside the IDE device
> driver...

S/390 has no IDE. That might be the reason why I faced depmod-problems if I
include ext3 and jbd-debug as module.
Nevertheless debugging seems to work if I compile ext3 in the kernel.

greetings



