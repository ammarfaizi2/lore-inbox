Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292881AbSB1AZB>; Wed, 27 Feb 2002 19:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293098AbSB1AY6>; Wed, 27 Feb 2002 19:24:58 -0500
Received: from renown.xo.com ([207.155.248.63]:58804 "EHLO renown.xo.com")
	by vger.kernel.org with ESMTP id <S293097AbSB1AYU>;
	Wed, 27 Feb 2002 19:24:20 -0500
Message-ID: <036801c1bfee$b5b0f780$1801010a@Mauser>
From: "Doug O'Neil" <DougO@seven-systems.com>
To: "lk" <linux-kernel@vger.kernel.org>
Subject: LFS Support for Sendfile
Date: Wed, 27 Feb 2002 16:27:30 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello group.

First time poster. If this isn't the right place for this then please point
me in the right direction and accept my apology.

I'm using Linux 2.4.12 on a PIII

I've been playing with sendfile and noticed that it doesn't like 64 bit
filesystems ( _FILE_OFFSET_BITS=64). Is there a patch or kernel revision out
there that supports LFS for sendfile?  Or is there some method I can't see
to work around this.

I'm opening a descriptor on a disk partition. I don't need to support
individual block transfers larger than 2 Gig., but would like to serve up
partitions that are larger than 2Gig.

Thanks in advance

Doug

