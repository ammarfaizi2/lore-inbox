Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275583AbTHMVNB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275584AbTHMVNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:13:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55822 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275583AbTHMVM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:12:59 -0400
Date: Wed, 13 Aug 2003 22:12:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Marshall <tommy@home.tig-grr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1410)
Message-ID: <20030813221254.H20676@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Marshall <tommy@home.tig-grr.com>,
	linux-kernel@vger.kernel.org
References: <20030813205037.GA11977@home.tig-grr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030813205037.GA11977@home.tig-grr.com>; from tommy@home.tig-grr.com on Wed, Aug 13, 2003 at 01:50:37PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 01:50:37PM -0700, Tom Marshall wrote:
> I have not been able to get PCMCIA support working in my TI-PCI1410 based
> system using the 2.6.0-test3 kernel.  It works with 2.4.21, although I have
> to do a "cardctl eject; cardctl insert" after the APM suspend/restore cycle. 
> The main chipset is i830m and the laptop is a Dell C400, if that matters.
> 
> In 2.6.0-test3, the syslog shows these messages when inserting my Orinoco
> card:
> 
>   Aug 10 15:55:33 venture cardmgr[312]: socket 0: Anonymous Memory
>   Aug 10 15:55:33 venture cardmgr[312]: executing: 'modprobe memory_cs'
>   Aug 10 15:55:33 venture cardmgr[312]: + FATAL: Module memory_cs not found.
>   Aug 10 15:55:33 venture cardmgr[312]: modprobe exited with status 1
>   Aug 10 15:55:33 venture cardmgr[312]: module /lib/modules/2.6.0-test3/pcmcia/memory_cs.o not available
>   Aug 10 15:55:33 venture cardmgr[312]: bind 'memory_cs' to socket 0 failed : Invalid argument

Could you show the kernel messages from boot as well as the above
messages please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

