Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVBOSft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVBOSft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVBOSft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:35:49 -0500
Received: from mail.tyan.com ([66.122.195.4]:28422 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261796AbVBOSfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:35:36 -0500
Message-ID: <3174569B9743D511922F00A0C943142308085826@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: X86_64 kernel support MAX memory.
Date: Tue, 15 Feb 2005 10:49:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a system with 8 way Opteron. Every CPU has 16G memory.

2.6 kernel x86_64, it will crash when it start the Fifth node.

YH

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Tuesday, February 15, 2005 4:08 AM
> To: YhLu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: X86_64 kernel support MAX memory.
> 
> On Mon, Feb 14, 2005 at 07:32:42PM -0800, YhLu wrote:
> > Andi,
> > 
> > How much is max RAM 2.6.11 x86_64 support on AMD64?
> > 64G or 128G?
> 
> 46bits in theory (64TB), however current CPUs only support 
> upto 40bits (AMD) or 36bits (Intel).  There is some other 
> code that is also limited to 40bits right now like AGP or 
> IOMMU or MTRR, that is all due to hardware limitations.
> 
> -Andi
> 
