Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUEYOzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUEYOzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 10:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUEYOzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 10:55:10 -0400
Received: from poup.poupinou.org ([195.101.94.96]:1079 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S264926AbUEYOxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 10:53:23 -0400
Date: Tue, 25 May 2004 16:52:59 +0200
To: Manuel Kasten <kasten.m@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [speedste-centrino] couldn't enable Enhanced SpeedStep
Message-ID: <20040525145259.GA10063@poupinou.org>
References: <200405231126.11815.kasten.m@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405231126.11815.kasten.m@gmx.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Bruno Ducrot <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 11:26:11AM +0200, Manuel Kasten wrote:
> Hello,
> 
> speedstep-centrino won't load on my laptop running 2.6.6 :
> 
> $ cat /var/log/dmesg | grep speedstep
> speedstep-centrino: found "Intel(R) Pentium(R) M processor 1500MHz": max
> frequency: 1500000kHz
> speedstep-centrino: couldn't enable Enhanced SpeedStep
> 
> 
...

> # CONFIG_X86_GX_SUSPMOD is not set
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
> # CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI is not set

Could you please try with CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
enabled?  Sometimes, the BIOS would require that the OS take
ownership of the performance stuff..

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
