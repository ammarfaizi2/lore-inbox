Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265120AbUD3QOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265120AbUD3QOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbUD3QOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:14:31 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:61456 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265151AbUD3QOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:14:23 -0400
Message-ID: <40927C7A.3030702@techsource.com>
Date: Fri, 30 Apr 2004 12:19:06 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: arjanv@redhat.com
CC: vda@port.imtp.ilyichevsk.odessa.ua,
       Tim Connors <tconnors+linuxkernel1083305837@astro.swin.edu.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au>	 <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>	 <slrn-0.9.7.4-14292-10175-200404301617-tc@hexane.ssi.swin.edu.au>	 <4091F38C.3010400@yahoo.com.au>	 <Pine.LNX.4.53.0404301646510.11320@tellurium.ssi.swin.edu.au>	 <18781898240.20040430121833@port.imtp.ilyichevsk.odessa.ua> <1083317615.4633.7.camel@laptop.fenrus.com>
In-Reply-To: <1083317615.4633.7.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Arjan van de Ven wrote:
>>Multimedia content (jpegs etc) is typically cached in
>>filesystem, so Mozilla polluted pagecache with it when
>>it saved JPEGs to the cache *and* then it keeps 'em in RAM
>>too, which doubles RAM usage. 
> 
> 
> well if mozilla just mmap's the jpegs there is no double caching .....
> 


What is cached in memory?  The original JPEG or the decoded raw image?

