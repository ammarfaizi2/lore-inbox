Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUE1Vuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUE1Vuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUE1Vrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:47:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36001 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263995AbUE1Vpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:45:41 -0400
Message-ID: <40B7B2F4.7080704@pobox.com>
Date: Fri, 28 May 2004 17:45:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nivedita Singhvi <niv@us.ibm.com>
CC: Arjan van de Ven <arjanv@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com> <40B7797F.2090204@pobox.com> <17750000.1085766378@flay> <20040528175724.GC9898@devserv.devel.redhat.com> <40B7984E.7040208@us.ibm.com> <40B799EB.8060000@pobox.com> <40B79DB0.6090209@us.ibm.com>
In-Reply-To: <40B79DB0.6090209@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Long term, when NIC hardware is more advanced, we'll want something that 
divides sockets/connections/etc. into per-CPU clusters...  something 
that's friendly to both SMP and NUMA+SMP configurations.

Or if enterprising companies get a clue, and open their NIC firmware, I 
bet we could do this now.

	Jeff


