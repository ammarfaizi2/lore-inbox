Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262699AbTCVMrI>; Sat, 22 Mar 2003 07:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262744AbTCVMrI>; Sat, 22 Mar 2003 07:47:08 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:54045 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262699AbTCVMrG>; Sat, 22 Mar 2003 07:47:06 -0500
From: Jos Hulzink <josh@stack.nl>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.65: oops: EIP at current_kernel_time +0x0f/0x40
Date: Sat, 22 Mar 2003 13:58:04 +0100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <200303221252.12226.josh@stack.nl> <200303221334.41355.josh@stack.nl> <20030322124607.GB30140@holomorphy.com>
In-Reply-To: <20030322124607.GB30140@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303221358.04312.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 March 2003 13:46, William Lee Irwin III wrote:
> On Sat, Mar 22, 2003 at 01:34:41PM +0100, Jos Hulzink wrote:
> > Gee, you guys are good. Now I'm only left wondering how this setting
> > could be reset to PIV, while I'm sure I set it to PII (as you can see
> > from earlier postings, I managed to get it running till a SCSI lockup
> > caused by probably IRQ prioblems). For now I'll not blame the kernel and
> > tell myself I'm stupid ;-)
>
> Which SCSI? I've been seeing numerous aic7xxx badnesses ca. whatever bk
> snapshot 2.5.65-mm2 was based on. Still looking for the use-after-free...

00:06.0 SCSI storage controller: Adaptec AIC-7880U

Onboard SCSI controller, MPS 1.4 enabled Intel 440 LX chipset (i.e. IRQ 
rerouting and stuff) Kernel is recompiled now (processor type change takes a 
while, for you need to recompile everything from scatch) to test the 
different IRQ settings, have dealt with problems like these before.

Note that I'm testing the official,plain Linus-2.5.65

Jos
