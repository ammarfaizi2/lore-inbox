Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWDTWsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWDTWsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWDTWsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:48:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:11679 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932097AbWDTWsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:48:36 -0400
Message-ID: <44480FBF.6090100@pobox.com>
Date: Thu, 20 Apr 2006 18:48:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Fabio Comolli <fabio.comolli@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Schedule for adding pata to kernel?
References: <1142869095.20050.32.camel@localhost.localdomain> <4422F10B.9080608@bootc.net> <44266499.3070809@t-online.de> <1143393969.2540.5.camel@localhost.localdomain> <b637ec0b0604180444y7828ac5aobb349324f87201c2@mail.gmail.com> <1145361613.18736.44.camel@localhost.localdomain> <20060418121326.GB25726@htj.dyndns.org>
In-Reply-To: <20060418121326.GB25726@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.9 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.9 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> [adding Jeff and linux-ide to cc list]
> 
> On Tue, Apr 18, 2006 at 01:00:13PM +0100, Alan Cox wrote:
>> On Maw, 2006-04-18 at 13:44 +0200, Fabio Comolli wrote:
>>> In case PIIX/ICH driver should not make it in 2.6.17, are you planning
>>> to release patches for 2.6.17-rc release cycle?
>> I've been on holiday and am now tied up in other work until the start of
>> May, at which point Jeff goes off and gets married so there may be some
>> delay.
>>
>> 2.6.17-rc actually has 95% of the stuff needed to drop the PATA drivers
>> in and I will try to do patches at least versus 2.6.17 final. The -rcs
>> will depend upon available time and also what gets integrated that
>> causes additional work (notably Tejun Ho's stuff will make much merge
> 
> BTW, my name is Tejun Heo.  Tejun Ho sounds horrible in Korean.
> 
>> work, although its work I'm very glad to do as the improvements and
>> hotplug support are all needed).
> 
> I'm currently working on port multiplier support.  My working tree now
> successfully probes and attaches all devices over the PM and I'm
> currently trying to get EH and hotplug to work with it nicely.
> EH/hotplug are being changed to support PM.  Effects on LLDDs are
> minimal but you can probably save some work by waiting for the next
> round of patches before porting to new EH.
> 
> I think/hope this can be finished in this week and bombard Jeff with
> patches (updated EH, NCQ, hotplug and PM) before the weekend, so that
> Jeff can have some time to review and hopefully merge some of it into
> #upstream before he goes off on honeymoon.  In some convoluted way,
> the patches will be my marriage gift, heh heh.
> 
> Jeff, *BIG* congratulations.  I wish you a great marriage.

Thanks :)  And thanks for working on this stuff...  As you see, once the 
EH hurdle is cleared, it is much easier to add new features.  New 
features will start flooding in, from you and others.

BTW don't forget we want to push Albert's irq-pio branch into upstream 
sometime soon after your EH work settles.  I would put irq-pio in front 
of NCQ and PM, particularly.

	Jeff



