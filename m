Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270384AbRHHH0a>; Wed, 8 Aug 2001 03:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270386AbRHHH0U>; Wed, 8 Aug 2001 03:26:20 -0400
Received: from mail.teraport.de ([195.143.8.72]:38785 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S270384AbRHHH0J>;
	Wed, 8 Aug 2001 03:26:09 -0400
Message-ID: <3B70E995.BE570736@TeraPort.de>
Date: Wed, 08 Aug 2001 09:26:13 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Admin Mailing Lists <mlist@intergrafix.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eepro100.c - Add option to disable power saving in2.4.7-ac7
In-Reply-To: <Pine.LNX.4.10.10108071655190.4770-100000@athena.intergrafix.net>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/08/2001 09:26:13 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/08/2001 09:26:20 AM,
	Serialize complete at 08/08/2001 09:26:20 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Admin Mailing Lists wrote:
> 
> On Mon, 6 Aug 2001, Martin Knoblauch wrote:
> 
> > Hi,
> >
> >  after realizing that my first attempt for this patch was to
> > enthusiastic, I have no a somewhat stripped down version. Compiles
> > against 2.4.7-ac7.
> >
> >  The patch adds the option "power_save" to eepro100. If "1" (default),
> > power save handling is done as normal. If "0", no power saving is done.
> > This is to workaround some flaky eepro100 adapters that do not survive
> > D0->D2-D0 transitions.
> >
> 
> i'm assuming if APM isn't configured in the kernel, these options dont
> matter?
> 

 hmm. I would assume that your assumption is correct.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
