Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWFBGju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWFBGju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWFBGjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:39:49 -0400
Received: from mx1.suse.de ([195.135.220.2]:19160 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751206AbWFBGjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:39:48 -0400
Message-ID: <447FDD32.7070403@suse.de>
Date: Fri, 02 Jun 2006 08:39:46 +0200
From: Hannes Reinecke <hare@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Jens Axboe <axboe@suse.de>,
       Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: State of resume for AHCI?
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>	 <20060601183904.GR4400@suse.de>  <447F4BC2.8060808@goop.org> <1149210165.13451.4.camel@forrest26.sh.intel.com>
In-Reply-To: <1149210165.13451.4.camel@forrest26.sh.intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zhao, forrest wrote:
> On Thu, 2006-06-01 at 13:19 -0700, Jeremy Fitzhardinge wrote:
>> Jens Axboe wrote:
>>> It's a lot more complicated than that, I'm afraid. ahci doesn't even
>>> have the resume/suspend methods defined, plus it needs more work than
>>> piix on resume.
>>>   
>> Hannes Reinecke's patch implements those functions, basically by 
>> factoring out the shutdown and init code and calling them at 
>> suspend/resume time as well.
>>
>> Is that correct/sufficient?  Or should something else be happening?
> 
> According to our test of Hannes's patch, it's not sufficient to support
> AHCI suspend/resume.
> 
> Now I'm writing a patch to try to provide complete support for AHCI
> suspend/resume and will send out patch soon, hopefully by the end of
> today.
> 
Can I have details, please? What doesn't work?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
