Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUJGSB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUJGSB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUJGSBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:01:23 -0400
Received: from postino4.roma1.infn.it ([141.108.26.24]:41197 "EHLO
	postino4.roma1.infn.it") by vger.kernel.org with ESMTP
	id S267522AbUJGRwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:52:13 -0400
Message-ID: <41658247.9060308@roma1.infn.it>
Date: Thu, 07 Oct 2004 19:52:07 +0200
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian McGrew <Brian@doubledimension.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI Burst and Overall System Speed (XEON)
References: <E6456D527ABC5B4DBD1119A9FB461E350193E2@constellation.doubledimension.com>
In-Reply-To: <E6456D527ABC5B4DBD1119A9FB461E350193E2@constellation.doubledimension.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.28.0.3; VDF 6.28.0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian McGrew wrote:

>I have a question about the PCI Bursting and overall processing speed on a dual Xeon box; but first I have to give a slight bit of background, (all of it relevant to the question) I'll try and keep it short.
>
>  
>
what do you mean by "PCI Bursting" ?? are you using DMA (PCI card Mem 
Write Multiple) or MMIO read (CPU Mem Read Line) ?

anyway on my system, 2 CPU Xeon 2.6GHz GC-LE + a custom PCI-X 100MHz 
card, I get
- 440.755 MByte/s, only 1 process
- 424.683 MByte/s, the process below running:
sh -c 'while true ; do echo miao ; done' > /dev/null

it's:
Linux xeino 2.4.22-1.2199.nptlsmp #1 SMP Wed Aug 4 11:48:29 EDT 2004 
i686 i686 i386 GNU/Linux

what is your kernel version?

regards

