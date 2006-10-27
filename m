Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWJ0XIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWJ0XIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWJ0XIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:08:09 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:29368 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750988AbWJ0XII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:08:08 -0400
Message-ID: <45429020.4000107@oracle.com>
Date: Fri, 27 Oct 2006 16:02:56 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Florin Malita <fmalita@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       proski@gnu.org, cate@debian.org, gianluca@abinetworks.biz
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	 <1161808227.7615.0.camel@localhost.localdomain>	 <20061025205923.828c620d.akpm@osdl.org>	 <20061026102630.ad191d21.randy.dunlap@oracle.com>	 <1161959020.12281.1.camel@laptopd505.fenrus.org>	 <20061027082741.8476024a.randy.dunlap@oracle.com>	 <20061027112601.dbd83c32.akpm@osdl.org>  <45428EAD.6040005@gmail.com> <1161990307.16839.50.camel@localhost.localdomain>
In-Reply-To: <1161990307.16839.50.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-10-27 am 18:56 -0400, ysgrifennodd Florin Malita:
>> Also, since driverloader is not GPL-compatible (MODULE_LICENSE("see
>> LICENSE file; Copyright (c)2003-2004 Linuxant inc.")), that check is
>> redundant. How about removing it (applies on top of Randy's patch)?
>>
>>
>> Signed-off-by: Florin Malita <fmalita@gmail.com>
> 
> NAK
> 
> Older versions of Linuxant's driverloader claim GPL\0some other text and
> systematically set out to abuse the license tag code. We should continue
> to carry the code for this.
> 
> Alan

I'm confused.  Do you mean that we should continue to treate driverloader
as GPL?  Oh, I guess I see.  You mean that we should continue to have
special code to override their "GPL\0other text" license.  OK.

-- 
~Randy
