Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279898AbRJ3JVH>; Tue, 30 Oct 2001 04:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279899AbRJ3JU5>; Tue, 30 Oct 2001 04:20:57 -0500
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:961 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279898AbRJ3JUn>; Tue, 30 Oct 2001 04:20:43 -0500
Message-ID: <3BDE7110.ED9AFB9A@mandrakesoft.com>
Date: Tue, 30 Oct 2001 04:21:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Realtek (VAIO laptop NIC) issue.
In-Reply-To: <3BDE3756.2D004085@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> When I do a warm reboot of my VAIO laptop, my realtek builtin NIC will not
> function (it sees received pkts, but can't seem to send anything).
> 
> A cold boot fixes it.  An rmmod/insmod does not.  Not a horribly
> big deal, but I thought I'd let you all know!  I was using 2.4.12-pre5
> I believe...

I assume by RealTek you mean 8139.  Please provide "lspci" or "dmesg" or
-something- other than "my realtek builtin NIC."

Can you try the latest 8139too.c from gkernel CVS? 
(http://sf.net/projects/gkernel/ checkout module "linux_2_4")

Does enabling CONFIG_8139TOO_PIO change things?

Can you get any output when enabling RTL8139_DEBUG?

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

