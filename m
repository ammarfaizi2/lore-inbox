Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWEZNWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWEZNWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 09:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWEZNWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 09:22:06 -0400
Received: from mail.axxeo.de ([82.100.226.146]:12256 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1750714AbWEZNWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 09:22:04 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Andi Kleen <ak@suse.de>
Subject: Re: Safe remote kernel install howto (Re: [Bugme-new] [Bug 6613] New: iptables broken on 32-bit PReP (ARCH=ppc))
Date: Fri, 26 May 2006 15:21:53 +0200
User-Agent: KMail/1.9.1
Cc: Meelis Roos <mroos@linux.ee>, kernel list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
References: <200605251004.k4PA4Lek007751@fire-2.osdl.org> <200605261429.36078.netdev@axxeo.de> <200605261442.32319.ak@suse.de>
In-Reply-To: <200605261442.32319.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261521.53884.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Andi Kleen wrote:
> > 4. Put "sysctl -w kernel.panic_on_oops=1" as early as possible
> >      in your boot scripts[1].
> 
> You can as well boot with oops=panic

Only on x86_64 as of Linux 2.6.16.
But maybe this could be put into kernel/panic.c instead :-)

Regards

Ingo Oeser
