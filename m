Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUABB1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 20:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbUABB1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 20:27:39 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:23176 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S262123AbUABB1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 20:27:38 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.0 non fatal recoverable errors crash gcc
Date: Thu, 1 Jan 2004 19:27:31 -0600
User-Agent: KMail/1.5.94
References: <3FF4B3E7.9050309@zwanebloem.nl>
In-Reply-To: <3FF4B3E7.9050309@zwanebloem.nl>
Cc: Tommy Faasen <tommy@zwanebloem.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401011927.31036.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 January 2004 05:57 pm, Tommy Faasen wrote:
> Hi,
>
> I'm not subscribed to this newsgroup, but i'll try to read the follow-up
> messages if any.
>
> When my machine is doing big compiles like the kernel or mythtv ,
> gcc/g++ crashes.
> This happens after syslog tell me  that there is a recoverable error
> (see output below).
> This happened several times but I don't know why and what I can do about
> it ..
> The machine seems to be very stable, but it could be a hardware problem
> i guess.
>
> I'm using a stock 2.6.0 kernel on a duron 1300 on a via kt133a chipset
> and has 640MB memory, extra information can be found below, if you need
> more information please let me know.
>
	Sounds like you have buggy hardware. I routinely use GCC to try to break 
machines because it is so CPU/Memory intensive. Because of the massive amount 
of work gcc does, it will push out bugs/problems in your hardware. I would 
recommend you look into it further. Overheating? Bad memory? Byggy chipset? 
Cheap mobo?
	Even if the system *seems* stable, I wouldn't trust it. You may have a VERY 
subtle hardware problem if the system seems stable otherwise. A normal 
program might only crash 1/1000 times with MCE where GCC will do it 1/10. 
Check out your hardware then reply back if that doesn't fix it.
	I tried to look up the error code, but man those proccessor spec manuals will 
run circles around your head sometimes. The best I could come up with is that 
your processor should never return MCE ;) MCE indicates some pretty heavy 
trouble with data maniupulation.
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
