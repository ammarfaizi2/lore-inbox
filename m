Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbRGPIf6>; Mon, 16 Jul 2001 04:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267234AbRGPIfs>; Mon, 16 Jul 2001 04:35:48 -0400
Received: from mail.teraport.de ([195.143.8.72]:21378 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S267233AbRGPIfj>;
	Mon, 16 Jul 2001 04:35:39 -0400
Message-ID: <3B52A757.8AFCD167@TeraPort.de>
Date: Mon, 16 Jul 2001 10:35:35 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: marcelo@conectiva.com.br
Subject: Re: [PATCH] VM statistics code
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/16/2001 10:35:11 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/16/2001 10:35:19 AM,
	Serialize complete at 07/16/2001 10:35:19 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Marcelo Tosatti wrote: 
>> 
>> Hi Linus, 
>> 
>> The following patch adds detailed VM statistics (reported via /proc/stats) 
>> which is tunable on/off by the CONFIG_VM_STATS option. 
>
>We need this, bad. Two suggested changes: 

 While this may only be noise, I completely agree. This kind of
statistics is absolutely needed. One question, do the stats in the patch
already cover the page and buffer caches?

Thanks
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
