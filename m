Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284182AbSAGRl6>; Mon, 7 Jan 2002 12:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284186AbSAGRli>; Mon, 7 Jan 2002 12:41:38 -0500
Received: from [62.245.135.174] ([62.245.135.174]:47545 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S284182AbSAGRlh>;
	Mon, 7 Jan 2002 12:41:37 -0500
Message-ID: <3C39DDC9.29F29E68@TeraPort.de>
Date: Mon, 07 Jan 2002 18:41:29 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: vanl@megsinet.net
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/07/2002 06:41:29 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/07/2002 06:41:36 PM,
	Serialize complete at 01/07/2002 06:41:36 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: [2.4.17/18pre] VM and swap - it's really unusable
> 
> 
> I did some tests with different VM-patches. I tested one ac-patch, too.
> I detected the same as you described - but the memory-consumption and
> the behaviour at all isn't better. If you want to, you can test another
> patch, which worked best in my test. It's nearly as good as kernel
> 2.2.x. Ask M.H.vanLeeuwen (vanl@megsinet.net) for his oom-patch to
> kernel 2.4.17.
> But beware: maybe this strategy doesn't fit to your applications. And
> it's not for productive use.
> I and some others surely too, would be interested in your experience
> with this patch.
> 
Hi,

 so I took the M.H.vL vmscan.c patch for 2.4.17 and it is a definite
winner for me. Sounds like 2.4.18 material.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
