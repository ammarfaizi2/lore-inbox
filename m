Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbUKNSVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUKNSVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 13:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUKNSVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 13:21:42 -0500
Received: from mail.charite.de ([160.45.207.131]:46220 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261326AbUKNSVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 13:21:40 -0500
Date: Sun, 14 Nov 2004 19:21:39 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac8
Message-ID: <20041114182138.GF5708@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1100186344.22254.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1100186344.22254.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:
> This just adds the binfmt fixes from Chris Wright. The other pending
> changes have been bumped to ac9
> 
> Various chunks of new IDE stuff and related cleanups. Most users probably
> don't want to upgrade to this kernel
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/
> 
> 2.6.9-ac8
> o	Fix binfmt_exec partial read problem		(Chris Wright)
> o	Fix E820 overflow on x86-64 as per x86-32	(Andi Kleen)

I'm seeing these with 2.6.9-ac8:

Nov 14 18:40:09 kasbah kernel: retrans_out leaked.                      
Nov 14 18:41:25 kasbah kernel: retrans_out leaked.                      
Nov 14 18:42:44 kasbah kernel: retrans_out leaked.                      

What is that?

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
