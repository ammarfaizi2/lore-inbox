Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269284AbRGaMhj>; Tue, 31 Jul 2001 08:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269286AbRGaMhb>; Tue, 31 Jul 2001 08:37:31 -0400
Received: from mail.teraport.de ([195.143.8.72]:44419 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S269284AbRGaMhX>;
	Tue, 31 Jul 2001 08:37:23 -0400
Message-ID: <3B66A684.A888F52D@TeraPort.de>
Date: Tue, 31 Jul 2001 14:37:24 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: pworach@mysun.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: eepro100 2.4.7-ac3 problems (apm related)
In-Reply-To: <Pine.LNX.4.33.0107311246360.3857-100000@chaos.tp1.ruhr-uni-bochum.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/31/2001 02:36:42 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/31/2001 02:36:49 PM,
	Serialize complete at 07/31/2001 02:36:49 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Kai Germaschewski wrote:
> 
> 
> Martin, if you want to spend some work on your problem, you could try to
> collect some more data an your problem, particularly what about using
> another state (D1/D3) when the interface is down. D3 will probably mean
> that you have to save/restore PCI config space, so it's a bit more
> tedious. Also, is there anything which makes your card work again after it
> was in state D2? Like suspend/resume, or putting it into D3 and back into
> D0? Does a warm reboot suffice, or do you need to power cycle.
> 

 Hmm. I am kind of lost now. I just redid the tests I did with 2.4.6-ac2
under 2.4.7-ac3 and my eepro100 merrily survives any number of
D0->D2->D0 transitions. The only difference besides the kernels is the
ambient temperature. It is quite hot right now - and we don't have AC.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
