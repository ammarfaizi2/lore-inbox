Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUBERdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUBERdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:33:00 -0500
Received: from intra.cyclades.com ([64.186.161.6]:38622 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266499AbUBERcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:32:54 -0500
Date: Thu, 5 Feb 2004 15:17:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Evaldo Gardenali <evaldo@gardenali.biz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem on __alloc_pages
In-Reply-To: <402244FE.5010107@gardenali.biz>
Message-ID: <Pine.LNX.4.58L.0402051516580.16120@logos.cnet>
References: <402244FE.5010107@gardenali.biz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Feb 2004, Evaldo Gardenali wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi.
> I am a newbie to kernel memory alloc, and got this on my server.
>
> Feb  5 11:09:39 server1 kernel: __alloc_pages: 1-order allocation failed
> (gfp=0x1f0/0)
> Feb  5 11:09:39 server1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1f0/0)
> Feb  5 11:10:36 server1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> Fev  5 11:11:39 server1 gconfd (evaldo-2337): Recebido sinal 15,
> desligando corretamente
> Fev  5 11:11:40 server1 gconfd (evaldo-2337): Terminando
> Feb  5 11:11:52 server1 /usr/sbin/gpm[437]: imps2: Auto-detected

Hi Evaldo,

Do you have swap space available when this happens?

