Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264121AbRFNWls>; Thu, 14 Jun 2001 18:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264132AbRFNWlj>; Thu, 14 Jun 2001 18:41:39 -0400
Received: from logger.gamma.ru ([194.186.254.23]:16147 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S264121AbRFNWlb>;
	Thu, 14 Jun 2001 18:41:31 -0400
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: Re: 2.4.5 data corruption
Date: 15 Jun 2001 02:27:22 +0400
Organization: Average
Message-ID: <9gbdoa$cpi$1@pccross.average.org>
In-Reply-To: <E15Abiw-00056O-00@the-village.bc.nu>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
X-Comment-To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15Abiw-00056O-00@the-village.bc.nu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> Folks, I believe I have a reproducible test case which corrupts data in
>> 2.4.5.
> 
> 2.4.5 has an out of date 3ware driver that is short

These days I observed massive FS curruption on vanilla 2.4.5,
SCSI disk on Sym53c8-something controller (UW).  I did not notice
any problems since 2.4.5 was published, they seem to have surfaced
immediately after I created a rather big file capturing video with
broadcast2000 (video card is bt848).  Filesystem is ext2.

Eugene
