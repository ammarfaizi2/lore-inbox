Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbWHJK5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbWHJK5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 06:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWHJK5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 06:57:12 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:25539 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161160AbWHJK5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 06:57:11 -0400
Date: Thu, 10 Aug 2006 12:56:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kbuild visuals
Message-ID: <20060810105656.GA23626@mars.ravnborg.org>
References: <Pine.LNX.4.61.0608100850050.10926@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608100850050.10926@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 08:52:51AM +0200, Jan Engelhardt wrote:
> Hi,
> 
> 
> just caught this little indentation issue on Kconfig output whilst 
> compiling 2.6.18-rc4 on x64:
> 
> [...]
>   AS      .tmp_kallsyms1.o
>   LD      .tmp_vmlinux2
>   KSYM    .tmp_kallsyms2.S
>   AS      .tmp_kallsyms2.o
>   LD      vmlinux
>   SYSMAP System.map
>   SYSMAP .tmp_System.map
>   AS      arch/x86_64/boot/bootsect.o
>   LD      arch/x86_64/boot/bootsect

I fixed that one just the other day. Has been there for ages.
Thanks for the report anyway.

	Sam
