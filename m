Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbTCVMXq>; Sat, 22 Mar 2003 07:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262741AbTCVMXq>; Sat, 22 Mar 2003 07:23:46 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:19246 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262728AbTCVMXo>; Sat, 22 Mar 2003 07:23:44 -0500
From: Jos Hulzink <josh@stack.nl>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.65: oops: EIP at current_kernel_time +0x0f/0x40
Date: Sat, 22 Mar 2003 13:34:41 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303221252.12226.josh@stack.nl> <20030322041758.3ee1fed8.akpm@digeo.com>
In-Reply-To: <20030322041758.3ee1fed8.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303221334.41355.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 March 2003 13:17, Andrew Morton wrote:
> Jos Hulzink <josh@stack.nl> wrote:
> > Hi,
> >
> > Here the early oops I'm stuck with in 2.5.65. Had to write it down
> > manually, so the report is not complete. If I missed something crucial,
> > please ask. The bug is easy to reproduce, so I can write anything down
> > you need.
> >
> > exact oops message scrolled away, console isn't set up yet, so I can't
> > scroll back.
> >
> > EIP at current_kernel_time +0x0f/0x40
>
> That might be an lfence instruction.  I suspect you've chosen the wrong
> CPU type?

Gee, you guys are good. Now I'm only left wondering how this setting could be 
reset to PIV, while I'm sure I set it to PII (as you can see from earlier 
postings, I managed to get it running till a SCSI lockup caused by probably 
IRQ prioblems). For now I'll not blame the kernel and tell myself I'm stupid 
;-)

Jos
