Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131252AbRCHBZw>; Wed, 7 Mar 2001 20:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRCHBZc>; Wed, 7 Mar 2001 20:25:32 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:55853 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131251AbRCHBZR>; Wed, 7 Mar 2001 20:25:17 -0500
Message-ID: <006301c0a765$3ca118e0$1601a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu> <20010307164052.B788@wirex.com>
Subject: Questions about Enterprise Storage with Linux
Date: Wed, 7 Mar 2001 19:17:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm seeking information in regards to a large Linux implementation we are
planning.  We have been evaluating many storage options and I've come up
with some questions that I have been unable to answer as far as Linux
capabilities in regards to storage.

We are looking at storage systems that provide approximately 1TB of capacity
for now and can scale to 10+TB in the future.  We will almost certainly use
a storage system that provides both fiber channel connectivity as well as
NFS connectivity.

The questions that have been asked are as follows (assume 2.4.x kernels):

1.  What is the largest block device that linux currently supports?  i.e.
Can I create a single 1TB volume on my storage device and expect linux to
see it and be able to format it?

2.  Does linux have any problems with large (500GB+) NFS exports, how about
large files over NFS?

3.  What filesystem would be best for such large volumes?  We currently use
reirserfs on our internal system, but they generally have filesystems in the
18-30GB ranges and we're talking about potentially 10-20x that.  Should we
look at JFS/XFS or others?

4.  We're seriously considering using LVM for volume management.  Does it
have size limits per volume or other limitations that we should be aware of?

I'm sure these answers are out there, but I haven't been able to find
definitive answers (it seems everyone has a different answer to each
question).  Any assistance in pointing me to the correct information would
be greatly appreciated.

Thanks,
Tom


