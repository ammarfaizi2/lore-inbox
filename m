Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280281AbRJaQDI>; Wed, 31 Oct 2001 11:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280279AbRJaQC6>; Wed, 31 Oct 2001 11:02:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:2829 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280281AbRJaQCv>;
	Wed, 31 Oct 2001 11:02:51 -0500
Subject: Re: i820 agp support ?
From: Robert Love <rml@tech9.net>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BDFF640.4020002@epfl.ch>
In-Reply-To: <3BDFF640.4020002@epfl.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 31 Oct 2001 11:03:28 -0500
Message-Id: <1004544209.1209.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-31 at 08:01, Nicolas Aspert wrote:
> It seems to me that the i820 chipset from Intel, which I have on my PC, 
> is not supported by the 'agpgart' module. Looking at the source (from 
> 2.4.13) shows that there is support for i810, i815 and then skips to i830.
> I have managed to use the module successfully with the nice 
> 'agp_try_unsupported=1' option (with a kernel 2.4.9 from RedHat), but 
> still something remain unclear to me, namely "why is the i820 still in 
> the 'unsupported' hardware ?".
> 
> Are there many major differences between i820 and the other Intel 
> chipsets ?
> 
> Thanks in advance for answering.

I will work on support for the i820 ... I don't believe there is any
particular reason we don't support it.  Please give me the output of

	/sbin/lspci -s 0 -v -n

on your i820 machine.

	Robert Love

