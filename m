Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290822AbSBLIEQ>; Tue, 12 Feb 2002 03:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290824AbSBLIEG>; Tue, 12 Feb 2002 03:04:06 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:38137 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S290822AbSBLID4>;
	Tue, 12 Feb 2002 03:03:56 -0500
Message-ID: <3C68CBB6.9050709@debian.org>
Date: Tue, 12 Feb 2002 09:00:54 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ford <david+cert@blue-labs.org>, kbuild-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel config core dump w/ bad inpu
In-Reply-To: <fa.fhrqjcv.n7sq1s@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2002 08:03:55.0269 (UTC) FILETIME=[D11C7350:01C1B39B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

> SYM53C8XX Version 2 SCSI support (CONFIG_SCSI_SYM53C8XX_2) [N/y/m/?] 
> (NEW) y
>  DMA addressing mode (CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE) [1] 
> (NEW) y
> scripts/Configure: line 245: 14353 Segmentation fault      (core dumped) 
> expr \( \( $ans + 0 \) \>= $min \) \& \( $ans \<= $max \) >/dev/null 2>&1


This is a bug of 'expr/bash', but anyway the the Configure should discard
non numeric value before to compare it.


	giacomo

 


