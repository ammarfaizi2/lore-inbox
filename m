Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277665AbRJMOlT>; Sat, 13 Oct 2001 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278306AbRJMOlJ>; Sat, 13 Oct 2001 10:41:09 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:13260 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277665AbRJMOk5>; Sat, 13 Oct 2001 10:40:57 -0400
Date: 13 Oct 2001 13:47:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8Ao$k$$1w-B@khms.westfalen.de>
In-Reply-To: <71714C04806CD51193520090272892178BD70D@ausxmrr502.us.dell.com>
Subject: Re: crc32 cleanups
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <71714C04806CD51193520090272892178BD70D@ausxmrr502.us.dell.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com  wrote on 12.10.01 in <71714C04806CD51193520090272892178BD70D@ausxmrr502.us.dell.com>:

> And, just when I thought I understood the crc32 stuff, here's an even better
> explanation/code/etc.  With thanks.

Except for one thing:

> 		for (i = 0; i < i; i++)

I don't think this does what was intended. Should that perhaps be

> 		for (i = 0; i < 1; i++)

? That would mean one pass through the loop, whereas the original does no  
passes through the loop.

MfG Kai
