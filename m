Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbTEFRDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263994AbTEFRDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:03:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:57899 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263993AbTEFRDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:03:18 -0400
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: Re: ISDN massive packet drops while DVD burn/verify
Date: Tue, 06 May 2003 18:46:06 +0200
Organization: None
Message-ID: <b98osj$sj8$1@fritz38552.news.dfncis.de>
References: <20030416151221.71d099ba.skraw@ithnet.com>	<Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>	<20030419193848.0811bd90.skraw@ithnet.com>	<1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>	<20030505164653.GA30015@pingi3.kke.suse.de>	<20030505192652.7f17ea9e.skraw@ithnet.com>	<1052218412.28797.18.camel@dhcp22.swansea.linux.org.uk>	<20030506143902.2b3fcecd.skraw@ithnet.com>	<1052225795.1201.11.camel@dhcp22.swansea.linux.org.uk> <20030506160153.44ea4eee.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, de-de
In-Reply-To: <20030506160153.44ea4eee.skraw@ithnet.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.19.0.3; VDF: 6.19.0.11; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.19.0.3; VDF: 6.19.0.11; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> On 06 May 2003 13:56:37 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> 
>>On Maw, 2003-05-06 at 13:39, Stephan von Krawczynski wrote:
>>
>>> HDIO_GET_MULTCOUNT failed: Invalid argument
>>> IO_support   =  0 (default 16-bit)
>>> unmaskirq    =  0 (off)
>>> using_dma    =  1 (on)
>>> keepsettings =  0 (off)
>>> readonly     =  0 (off)
>>> BLKRAGET failed: Invalid argument
>>> HDIO_GETGEO failed: Invalid argument
>>> 
>>>
>>>using_dma means it's using dma for transfer, right?
>>
>>Except for certain operations like audio cd ripping
> 
> 
> Not used here.
> We are using the DVDs (DVD-R) for data backups, some dozens a month.
> And keep in mind: the problem occurs currently only while writing to DVD, not
> while reading it.
> 

DVD writing seems to be problematic in other places too. I lose several
minutes of system time when I write a DVD. This is with SuSE 8.2 (SuSE
vendor kernel 2.4.20 based)

Wolfgang

> Regards,
> Stephan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


