Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUIPRzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUIPRzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUIPRyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:54:35 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:21520 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268502AbUIPRvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:51:45 -0400
Message-ID: <4149D4C2.5070907@hp.com>
Date: Thu, 16 Sep 2004 14:00:34 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Christoph Lameter <clameter@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
References: <200409161003.39258.bjorn.helgaas@hp.com>	 <200409160909.12840.jbarnes@engr.sgi.com> <1095349940.22739.34.camel@localhost.localdomain>
In-Reply-To: <1095349940.22739.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Iau, 2004-09-16 at 17:09, Jesse Barnes wrote:
>  
>
>>I think Christoph already looked at that.  And HPET doesn't provide mmap 
>>functionality, does it?  I.e. allow a userspace program to dereference the 
>>counter register directly?
>>    
>>
>
>It can do but that assumes nothing else is mapped into the same page
>that would be harmful or reveal information that should not be revealed
>etc..
>
>  
>
HPET driver does provide mmap for user programs. 

I agree with caution of other device registers in the same page. 
