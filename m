Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVCECWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVCECWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbVCEB7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:59:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:14294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263522AbVCEBkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:40:35 -0500
Date: Fri, 4 Mar 2005 17:40:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Something is broken with SATA RAID ?
Message-Id: <20050304174010.72ca7daa.akpm@osdl.org>
In-Reply-To: <1109980521l.13844l.0l@werewolf.able.es>
References: <1109810381l.5754l.0l@werewolf.able.es>
	<20050303005210.GA1140@havoc.gtf.org>
	<1109980521l.13844l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> One piece at last...
>  I have tried
>  - 2.6.11
>  - 2.6.11 + libata-dev1 + netdev1 + shrinkers-at-tail + 1Gb-lowmem
> 
>  Bot work fine and survived several gigas dumped both through smb and afp.
>  Happy man ;).
> 
>  If there was something strange, it must be in -mm. rc5-mm1 did not work,
>  but plain 2.6.11 works. I will try 2.6.11-mm1 on monday...

Please enable NMI watchdog, CONFIG_DETECT_SOFTLOCKUP and try sysrq-T and
sysrq-P.  See if we can somehow get a trace.

