Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313529AbSDMJrP>; Sat, 13 Apr 2002 05:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313541AbSDMJrP>; Sat, 13 Apr 2002 05:47:15 -0400
Received: from 212-100-182-25.adsl.easynet.be ([212.100.182.25]:49374 "HELO
	sumax.dyndns.org") by vger.kernel.org with SMTP id <S313529AbSDMJrO>;
	Sat, 13 Apr 2002 05:47:14 -0400
Date: Sat, 13 Apr 2002 11:47:06 +0200
From: chrisp@belgacom.net
To: linux-kernel@vger.kernel.org
Cc: alex14641@yahoo.com
Subject: Re: 2.4 sound crashes and oopses
Message-ID: <20020413114706.A300@freedaemon.home.lan>
Mail-Followup-To: chrisp@belgacom.net, linux-kernel@vger.kernel.org,
	alex14641@yahoo.com
In-Reply-To: <20020413005208.22935.qmail@web9203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: FreeBSD 4.5-STABLE i386
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 05:52:08PM -0700, Alex Davis wrote:
> What motherboard do you have? Also, type
> 
>    lspci -v
> 
> and post the results.If your sound card is using IRQ 7, it may be conflicting with
> your parallel port.
>
Asus VL/I-486SV2GOX4 Rev 1.2 board, 
it has no PCI bus (only VLB/ISA). Chipset: SIS85C471
The sound card is using IRQ 5, the parallel port is on IRQ 7.
After reading some source and similar problem reports, i think it might
be some buggy hardware instead of a kernel bug, i'll try to find out.

Chris 
