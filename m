Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSHNMUx>; Wed, 14 Aug 2002 08:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSHNMUx>; Wed, 14 Aug 2002 08:20:53 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59387 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317624AbSHNMUw>; Wed, 14 Aug 2002 08:20:52 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020814.11334845@knigge.local.net> 
References: <20020814.11334845@knigge.local.net>  <3D450B0F.4090901@yahoo.com> <200208141109.g7EB9hp15788@Port.imtp.ilyichevsk.odessa.ua> 
To: Michael Knigge <Michael.Knigge@set-software.de>
Cc: Stas Sergeev <stssppnn@yahoo.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Aug 2002 13:24:19 +0100
Message-ID: <20850.1029327859@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael.Knigge@set-software.de said:
> > Well, there is (currently) no intention to get it into the mainstream
> > kernel so don't treat it too seriously.

> Oh, I would love to see that thing in the Standard-Kernel....

Wait for people to stop using the 8254 timer for timer ticks, and you can 
have it all to yourself -- the timer abuse is the main reason the driver
was never suitable for inclusion.

Actually, now that HZ is easier to vary, you can switch it to a power of 2 
and use the RTC for it, again leaving you the 8254 for your own nefarious 
purposes.

--
dwmw2


