Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVJFLxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVJFLxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 07:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVJFLxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 07:53:17 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:24762 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750806AbVJFLxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 07:53:16 -0400
Message-ID: <43451008.2090305@emc.com>
Date: Thu, 06 Oct 2005 07:52:40 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Madore <Michael.Madore@aslab.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Pasi Pirhonen <upi@papat.org>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>,
       scott olson <scotto701@yahoo.com>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>,
       Evgeny Rodichev <er@sai.msu.su>
Subject: Re: [PATCH 2.6.14-rc2 1/2] libata: Marvell spinlock fixes and simplification
References: <20051005210610.EC31826369@lns1058.lss.emc.com>	 <20051005210842.F366B26369@lns1058.lss.emc.com> <1128551744.4041.7.camel@drevil.aslab.com>
In-Reply-To: <1128551744.4041.7.camel@drevil.aslab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.10.6.8
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Madore wrote:
> I assume this patch doesn't address the 'abnormal status 0x80' issue on
> the 6081.

Correct assumption.  This message seems benign as I've seen it and am 
working fine despite it.  I'll take a look soon.

Is the driver working for you on the 6081?

> On the 5081, I still get two machine checks followed by a
> hard lockup when I load the driver.

Would you turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in 
include/linux/libata.h and send along the console output when loading 
the driver?

Thanks,
BR
