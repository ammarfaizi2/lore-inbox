Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbTEFMDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTEFMDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:03:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60838
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262642AbTEFMDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:03:49 -0400
Subject: Re: 2.5.68-mmX: Drowning in irq 7: nobody cared!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@digeo.com>, Shane Shrybman <shrybman@sympatico.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0305060636560.13957-100000@montezuma.mastecende.com>
References: <1052141029.2527.27.camel@mars.goatskin.org>
	 <20030505143006.29c0301a.akpm@digeo.com>
	 <1052213733.28797.1.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.50.0305060636560.13957-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052219863.28797.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 12:17:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 11:41, Zwane Mwaikambo wrote:
> > For anything where you get pairs of close IRQ's
> 
> Shouldn't this also be observed more easily on P4/xAPIC since you can have 
> a pending vector in the IRR and ISR whilst the core processes one.

I don't know enough about the pending vector stuff. For the older APIC the
IRQ's go via a suprisingly slow seperate APIC bus (4 wire if I remember
rightly). 

