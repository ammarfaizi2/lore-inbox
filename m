Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270483AbTHLROI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271041AbTHLROI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:14:08 -0400
Received: from pwmail.portoweb.com.br ([200.248.222.108]:22749 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270483AbTHLROE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:14:04 -0400
Date: Tue, 12 Aug 2003 14:16:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: "Gabor Z. Papp" <gzp@papp.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPPoE Oops with 2.4.22-rc
In-Reply-To: <5ff3.3f388c4b.4453f@gzp1.gzp.hu>
Message-ID: <Pine.LNX.4.44.0308121415540.10199-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Aug 2003, Gabor Z. Papp wrote:

> I'm getting Oopses at reboots while pppoe module loaded.
> 
> Linux 2.4.22-pre* and -rc*
> pppd version 2.4.2b3
> 
> The ksymoops output attached, more details at
> http://gzp.odpn.net/tmp/linux-pppoe-oops/
> 
> ksymoops 2.4.9 on i686 2.4.22-rc2-gzp1.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.22-rc2-gzp1/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Oops: 0002
> CPU:    0
> EIP:    0010:[<e0ed9bce>]    Tainted: PF

Why is your kernel tainted?

Are you using stock 2.4.22-rc2 or do you have any additional 
patches/modules running? 

