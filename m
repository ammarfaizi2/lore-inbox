Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbREOUts>; Tue, 15 May 2001 16:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbREOUtj>; Tue, 15 May 2001 16:49:39 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:18953 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261495AbREOUt3>; Tue, 15 May 2001 16:49:29 -0400
Date: 15 May 2001 21:33:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <80wQzzS1w-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3B016F9A.360A0CFD@mandrakesoft.com> <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 15.05.01 in <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>:

> just incredibly stupid today. There's a script for doing exactly this for
> SCSI. I forget what it's called, because I obviously think the thing is
> stupid, but giving people the power to do even silly things is what Linux
> is all about.

Are you maybe talking about scsidev? It can produce names like /dev/scsi/ 
sdh24-e000c0i12l0p1 (ugh). It can *also* create names like
/dev/scsi/QAt-p3 for "that's the third partition on the Quantum Atlas, I  
shouldn't put important stuff there because Quantums like to break". (The  
QAt part comes from a config file.)

The latter I've used for quite a while (until I found mount-by-UUID). The  
former is unspeakably ugly.

MfG Kai
