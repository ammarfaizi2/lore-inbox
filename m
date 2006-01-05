Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWAEXMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWAEXMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWAEXMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:12:05 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:25623 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932263AbWAEXMB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:12:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N2v+HjIl2kU0Ub87tpvDWedWvkgfskdr7Kd3PVabeppfkMK79VYmwh7vIeFpKMbK1Z6PWreb2A+hE/2S1noMycSMMG7NeVPzbvhSdJi+BzUJ/D6cIllG+g42S8JEqdnMj2pY+Tkm6+KiDoRbUeZJHHuaBByDsWrjisEbA1b+yzw=
Message-ID: <9a8748490601051512w72ea0baekd52d991d2984c017@mail.gmail.com>
Date: Fri, 6 Jan 2006 00:12:00 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
Subject: Re: Oops with 2.6.15
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43BDA76F.1000906@pin.if.uz.zgora.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43BDA76F.1000906@pin.if.uz.zgora.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Jacek Luczak <difrost@pin.if.uz.zgora.pl> wrote:
> HI all
>
> I receive this Oops (see below) with kernels from 2.6.15-rc5 to 2.6.15
> (I haven't using earlier versions of 2.6.15-rc). I'm using sk98lin
> driver (version 8.28.1.3) from Syskonnect and ndiswrapper-1.7. Is this
> error caused by sk98lin driver?
>
It might be.
As long as you are running a tainted kernel, getting people to look
seriously at an oops is going to be hard - no way to debug the
binary-only code that tainted the kernel, so it's pretty impossible to
know what's going on.

[snip]
> Jan  5 19:25:04 slawek kernel: Modules linked in: sk98lin ndiswrapper
> usbhid uhci_hcd i915
> Jan  5 19:25:04 slawek kernel: CPU:    0
> Jan  5 19:25:04 slawek kernel: EIP:    0060:[<c0138603>]    Tainted: P

Try and reproduce with a non-tainted kernel.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
