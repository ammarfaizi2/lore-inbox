Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTAENBl>; Sun, 5 Jan 2003 08:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbTAENBl>; Sun, 5 Jan 2003 08:01:41 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:45537 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264730AbTAENBk>; Sun, 5 Jan 2003 08:01:40 -0500
Message-ID: <3E183D04.8040405@enib.fr>
Date: Sun, 05 Jan 2003 14:11:16 +0000
From: XI <xizard@enib.fr>
Organization: http://www.chez.com/xizard
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
References: <200301051004.h05A4bxs000499@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
 >>>SBline doesn't share interrupts well.  Usually, changing PCI slots in
 >>>order to affect what interrupt is used can help a lot.  The problem is,
 >>>depending on the motherboard, figuring out what a particular PCI slot
 >>>shares an interrupt with can be difficult.
 >>
 >>After some time, I have tested ALL possibilities with my PCI graphic
 >>card and my sound blaster live. (4 PCI slots => 12 possibilities).
 >>
 >>The problem is always the same, sound still stutter.
 >>
 >>
 >>Sum-up of my problem:
 >>The sound of my computer stutter when I move a window, watch a movie,
 >>... with a kernel 2.4.19 and 2.4.20 ; whereas with a kernel 2.4.8, it
 >>works fine.
 >>I use a sound blaster live! with a Matrox G200 PCI, and an AMD 760MPX
 >>chipset.
 >
 >
 > Try adding this line to the "Device" section of your XF86Config file:
 >
 > Option	"PciRetry"	"true"
 >
 > and let us know if it stops the stuttering or not.
 >
 > John.

Hi,
This option is already set in my XF86Config-4 file. It doesn't solve the
problem.

Thanks,
		Xavier



