Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161430AbWBUIVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161430AbWBUIVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWBUIVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:21:04 -0500
Received: from mailgate.hob.de ([62.91.19.101]:1246 "EHLO mailgate.hob.de")
	by vger.kernel.org with ESMTP id S1161430AbWBUIVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:21:01 -0500
Message-ID: <43FACD69.4020602@hob.de>
Date: Tue, 21 Feb 2006 09:20:57 +0100
From: Christian Hildner <christian.hildner@hob.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: de-de, de
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Maule <maule@sgi.com>, Christoph Hellwig <hch@infradead.org>,
       akpm@osdl.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
References: <20060214162337.GA16954@sgi.com>	 <20060220201713.GA4992@infradead.org>  <20060221024710.GB30226@sgi.com> <1140508994.3082.16.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven schrieb:

>On Mon, 2006-02-20 at 20:47 -0600, Mark Maule wrote:
>  
>
>>On Mon, Feb 20, 2006 at 08:17:14PM +0000, Christoph Hellwig wrote:
>>    
>>
>>>On Tue, Feb 14, 2006 at 10:23:37AM -0600, Mark Maule wrote:
>>>      
>>>
>>>>Export sn_pcidev_info_get.
>>>>        
>>>>
>>>Tony or Andrew please back this out again.  The only reason SGI wants this is
>>>to support their illegal graphics driver, and no core code uses it.
>>>
>>>And Mark, please stop submitting such patches.
>>>      
>>>
>>All I'm doing by exporting sn_pcidev_info_get is allowing a module to use
>>the SGI SN_PCIDEV_BUSSOFT() macro which will tell a driver which piece of
>>altix PCI hw its device is sitting behind (e.g. PCIIO_ASIC_TYPE_TIOCP et. al).
>>
>>While I acknowledge that the gfx driver folks requested this, I don't
>>understand what is "illegal" about this export, or the driver which wants
>>to use it.  What am I missing here?
>>    
>>
>
>so you would have no objection to making this a _GPL export ?
>
Hi Folks,

sn_* symbols are "their" symbols so I can't see any legitimation for 
anyone else to not let them export their symbols as they want. They are 
doing a great job on linux to make it run scalable on the biggest 
machines on earth. Or don't you like the idea of running Linux on those 
supercomputers?

Christian


