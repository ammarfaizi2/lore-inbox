Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284220AbRLFUl4>; Thu, 6 Dec 2001 15:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284211AbRLFUkl>; Thu, 6 Dec 2001 15:40:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:2067 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285183AbRLFUkF>; Thu, 6 Dec 2001 15:40:05 -0500
Message-ID: <3C0FD78D.F567ECBD@zip.com.au>
Date: Thu, 06 Dec 2001 12:39:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: temporarily system freeze with high I/O write to ext2 fs
In-Reply-To: <Pine.LNX.4.30.0112061458360.15516-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> hi all
> 
> why is it that Linux 'hangs' while doing heavy I/O operations (such as dd)
> to (and perhaps from?) ext2 file systems? I can't see the same behaivour
> when using other file systems, such as ReiserFS
> 

A partial fix for this went into 2.4.17-pre2.  What kernel are you
using?

For how long does it "hang"?   What exactly are you doing when it
occurs?

Is your disk system well-tuned?  What throughput do you get with
`hdparm -t /dev/hdXX'?

It surprises me that resierfs behaves differently...

-
