Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUIPSCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUIPSCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268453AbUIPR77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:59:59 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:32774 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S268186AbUIPR6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:58:35 -0400
Message-ID: <4149D655.5070904@hp.com>
Date: Thu, 16 Sep 2004 14:07:17 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@engr.sgi.com>, venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
References: <200409161003.39258.bjorn.helgaas@hp.com> <Pine.LNX.4.58.0409160930300.6765@schroedinger.engr.sgi.com> <200409161054.51467.bjorn.helgaas@hp.com>
In-Reply-To: <200409161054.51467.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:

>On Thursday 16 September 2004 10:32 am, Christoph Lameter wrote:
>  
>
>>On Thu, 16 Sep 2004, Bjorn Helgaas wrote:
>>    
>>
>>>Christoph Lameter wrote:
>>>      
>>>
>>>>The timer hardware was designed around the multimedia timer specification by Intel
>>>>but to my knowledge only SGI has implemented that standard. The driver was written
>>>>by Jesse Barnes.
>>>>        
>>>>
>>>As far as I can see, drivers/char/hpet.c talks to the same hardware.
>>>HP sx1000 machines (and probably others) also implement the HPET.
>>>      
>>>
>>The Intel Multimedia Standard is a earlier and different timer spec.
>>    
>>
>
>I have a spec that's labelled "IA-PC Multimedia Timers", preliminary
>draft of June 2000, revision 0.97, which looks like the one mentioned
>in your patch.
>
>I also have something labelled "IA-PC HPET (High Precision Event
>Timers) Specification", draft of February 2002, revision 0.98,
>which is what drivers/char/hpet.c supports.
>
>I admit I haven't compared them in great detail, but they certainly
>*look* like they're close enough that the same driver could support
>both, and the 0.98 revision history only mentions fairly cosmetic
>changes (like the name :)).
>
>Is there something specific that drivers/char/hpet.c expects that
>your hardware doesn't implement?
>
>  
>
Look at HPET revision history.  Specifically 0.98 01/20/2002
    * Product name changed: from Multimedia Timer to HPET (High 
Precision Event Timer)

Bob
