Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbTGIQoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268411AbTGIQoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:44:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29617
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268410AbTGIQoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:44:04 -0400
Subject: Re: ACPI status in 2.5.x/2.6.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Daniel <daniel@hawton.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307090938160.4625@bigblue.dev.mcafeelabs.com>
References: <3F0BD5D1.2010801@hawton.org>
	 <Pine.LNX.4.55.0307090938160.4625@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057769763.6262.65.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 17:56:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 17:40, Davide Libenzi wrote:
> 
> http://www.xmailserver.org/linux-patches/misc.html#SiSRt
> 
> Even if I am not much confident about success in your case. Also, I
> believe Alan was working of fixing ACPI for SiS. You might want to check.

2.4.22pre has the workaround for SiS APIC and that seems to make ACPI
generally work. I've actually been rewriting chunks of the IRQ router
code today and included the SiS fixups and detection Davide did.

