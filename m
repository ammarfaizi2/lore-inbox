Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTIRISB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 04:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbTIRISB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 04:18:01 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:18693 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263019AbTIRIR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 04:17:59 -0400
Message-ID: <3F696C36.4020604@aitel.hist.no>
Date: Thu, 18 Sep 2003 10:26:30 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Terje Eggestad <terje.eggestad@scali.com>, Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Rik's list of CS challenges
References: <Pine.LNX.4.44.0309101540270.27932-100000@chimarrao.boston.redhat.com>	 <1063792350.2853.73.camel@pc-16.office.scali.no> <1063806002.12270.31.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2003-09-17 at 10:52, Terje Eggestad wrote:
> 
>>What become more interesting is that while you may have NV RAM, it's not
>>likely that MRAM is viable on the processor chip. The manufacture
>>process may be too expensive, or outright impossible, (polymers on chips
>>that hold 80 degrees C in not likely), leaving you with volatile
>>register and cache but NV Main RAM. 
> 
> 
> We effectively handle that case now with the suspend-to-ram feature.
> 
> 
>>A merge of FS and RAM? (didn't the AS/400 have mmap'ed disks?)
> 
> 
> Persistant storage systems. These tend to look very unlike Linux because
> they throw out the idea of a file system as such. The issues with
> debugging if they break and backups make my head hurt but other folk
> seem to think they are solved problems

I see no reason to get rid of file systems - they provide a nice
and established way of organizing data.  Persistent RAM offer
other advantages though - no need for disk caching, mmap
simply gives access to the memory, execute without loading first.

Helge Hafting

