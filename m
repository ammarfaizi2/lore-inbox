Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280988AbRKTIV6>; Tue, 20 Nov 2001 03:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280992AbRKTIVs>; Tue, 20 Nov 2001 03:21:48 -0500
Received: from mailer.zib.de ([130.73.108.11]:10920 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S280988AbRKTIVf>;
	Tue, 20 Nov 2001 03:21:35 -0500
Date: Tue, 20 Nov 2001 09:21:23 +0100
From: Sebastian Heidl <heidl@zib.de>
To: Akshat Kapoor <akshat@mercurykr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query - How to Send Signal to application from kernel module !
Message-ID: <20011120092123.R5446@csr-pc1.zib.de>
In-Reply-To: <001401c17192$ebf8ce80$150d85a5@mercurykr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001401c17192$ebf8ce80$150d85a5@mercurykr.com>; from akshat@mercurykr.com on Tue, Nov 20, 2001 at 12:43:52PM +0530
X-www.distributed.net: 27 OGR packets (3.56 Tnodes) [4.21 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 12:43:52PM +0530, Akshat Kapoor wrote:
> Is it possible in Linux to send  a signal to an application from a driver ?
> I've done this in Windows NT but Idont know how to do it in Linux. I
have a look at kernel/signal.c
I think you can use all the send_* force_* and kill_* functions but I'm not sure
with this. Currently I used kill_proc_info and force_sig and they worked just
fine.

HTH,
_sh_

