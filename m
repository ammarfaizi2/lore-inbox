Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293242AbSCAOym>; Fri, 1 Mar 2002 09:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293219AbSCAOyd>; Fri, 1 Mar 2002 09:54:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293201AbSCAOyW>; Fri, 1 Mar 2002 09:54:22 -0500
Date: Fri, 1 Mar 2002 09:54:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Matthew Allum <mallum@xblox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
In-Reply-To: <3C7F93B6.904@xblox.net>
Message-ID: <Pine.LNX.3.95.1020301095154.331A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Matthew Allum wrote:

> Hi ;
> I've been attempting to get Linux to run on a Fujitsu pt510 [1], 
> unfortunatly without much success. The kernels die almost instantly 
> after cpu initialisation. I have tried both a debian woody stock 2.2 
> kernel and a home built 2.4.17 kernel both built for 386. Attached is 
> the kymoops output for the 2.4.17 kernel. 
> 
> Id really appreciate some help on this matter. Theres plenty of these 
> 510's on ebay at the moment going very cheapy ( 100$) and they'd make 
> nice wireless 'web pads'.
> 
> Many thanks;

Turn off CONFIG_X86_WP_WORKS_OK and CONFIG_X86_CMPXCHG. This allows
booting using Linux Version 2.4.1.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

