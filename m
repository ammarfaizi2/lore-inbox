Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285190AbRLFUsj>; Thu, 6 Dec 2001 15:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285189AbRLFUrB>; Thu, 6 Dec 2001 15:47:01 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:41413 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S284248AbRLFUqG>; Thu, 6 Dec 2001 15:46:06 -0500
Date: 06 Dec 2001 20:12:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
cc: torvalds@transmeta.com
Message-ID: <8EK0gp-1w-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0112060958450.10625-100000@penguin.transmeta.com>
Subject: Re: Linux/Pro  -- clusters
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E16C2qa-0002RR-00@the-village.bc.nu> <Pine.LNX.4.33.0112060958450.10625-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 06.12.01 in <Pine.LNX.4.33.0112060958450.10625-100000@penguin.transmeta.com>:

> Some of them are effectively turned off - the format timeout was increased
> to 2 hours to make sure that it basically never triggers.

And I recently found out the hard way that wasn't enough, and ended up  
cludging a utility to patch a running kernel (don't ask) to increase that  
timeout. Turned out the drive needed a little over three hours to tell me  
it couldn't format.

Frankly, format should really have NO timeout. Or possibly a user- 
specified one.

MfG Kai
