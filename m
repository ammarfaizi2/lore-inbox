Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSGXK05>; Wed, 24 Jul 2002 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSGXK05>; Wed, 24 Jul 2002 06:26:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25356 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316786AbSGXK04>; Wed, 24 Jul 2002 06:26:56 -0400
Message-ID: <3D3E806B.4060109@evision.ag>
Date: Wed, 24 Jul 2002 12:24:43 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <Pine.SOL.4.30.0207231530450.29134-100000@mion.elka.pw.edu.pl> <3D3D6122.5010207@evision.ag> <20020723195231.GA14288@ravel.coda.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
> On Tue, Jul 23, 2002 at 03:58:58PM +0200, Marcin Dalecki wrote:
> 
>>That's actually not true... At least the setting of the
>>request rq->flags is significantly different here and there.
>>However I think but I'm not sure that the fact aht we have rq->special 
>>!= NULL here has the hidded side effect that we indeed accomplish the
>>same semantics.
>>
>>
>>>And yes it will be useful to move it to block layer.
>>
>>Done. Just needs testing. I have at least an ZIP parport drive, which
>>allows me to do some basic checks.
> 
> 
> Ehh, you are testing all those IDE changes with a ZIP drive connected to
> the parallel port? Don't you have any real IDE devices?? I'm sure we can
> all chip in and buy you a drive if you need one.

For Gods sake not! The ZIP drive is a SCSI device. And the change to the
SCSI subsystems involves only trivial code movearound. For this
purpose it should be sufficient to trigger it with the above device.

