Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTE1Xci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTE1Xci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:32:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61328 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261741AbTE1Xcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:32:35 -0400
Message-ID: <3ED54A24.5010102@pobox.com>
Date: Wed, 28 May 2003 19:45:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: Re: RFC Proposal to enable MSI support in Linux kernel
References: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com> <Pine.LNX.4.50.0305201447460.20429-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0305281650110.4964-100000@montezuma.mastecende.com> <3ED53FE3.8090503@pobox.com> <Pine.LNX.4.50.0305281854180.4964-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0305281854180.4964-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Wed, 28 May 2003, Jeff Garzik wrote:
>>A bigger question though:  if platform_legacy_irq() returns zero, will 
>>the handler _ever_ be edge-triggered?
> 
> 
> Good question, i wouldn't think so, that would collapse that section into 
> two lines.


Have you ever seen an edge-triggered interrupt on x86 that would fail 
the current platform_legacy_irq test?  For what cases does that happen? 
  The legacy interrupts on the boxes I poked at are edge triggered, but 
I do not know enough to say if that is a general rule.

	Jeff



