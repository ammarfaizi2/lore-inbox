Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUE0Nql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUE0Nql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUE0Nql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:46:41 -0400
Received: from nyx.chaos.hu ([193.109.253.81]:40119 "EHLO mail.chaos.hu")
	by vger.kernel.org with ESMTP id S264524AbUE0Nqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:46:30 -0400
Date: Thu, 27 May 2004 15:46:30 +0200
From: Kerekes Gyula <gyula@harcinyul.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at smpboot.c:1098 on 2.4.24 kernel
Message-ID: <20040527134630.GF27908@harcinyul.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had the same bug on one of our DL380 machines.
The sollution: Set the OS type to Linux in BIOS. And everything works well
with the same kernel. (Especially 2.4.25 here)

Gyula

> I have a number of Compaq DL3x0 machines which are SMP PentiumIII's in
> single and dual-cpu configurations. With 2.4.23 sources I built SMP
> kernels and booted them just fine on UP boxes. Apparently no more. This
> is the output I get upon SMP kernel load on a UP box:
>
> <begin>
> Wierd, boot CPU (#15) not listed by the BIOS
> enabled ExtINT on CPU #0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Kernel BUG at smpboot.c:1098!
> invalid operand: 0000
> CPU:0

[...]
