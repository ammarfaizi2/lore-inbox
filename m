Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130934AbRBWEu5>; Thu, 22 Feb 2001 23:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131286AbRBWEuq>; Thu, 22 Feb 2001 23:50:46 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:33288 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S130934AbRBWEub>; Thu, 22 Feb 2001 23:50:31 -0500
Message-ID: <003501c09d53$9087d000$1601a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Jeff Lessem" <Jeff.Lessem@Colorado.EDU>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200102220719.AAA398825@ibg.colorado.edu> <000201c09d0c$d53a73c0$25040a0a@zeusinc.com>  <200102230327.UAA452494@ibg.colorado.edu>
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
Date: Thu, 22 Feb 2001 23:45:51 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I took your advice and used the kernel drivers from 2.4.2.  I built
> the Cardbus and i82365 drivers into the kernel.  This shows the exact
> same behavior, after a power-on reboot I get:

You don't need the i82365 driver, only the Cardbus (yenta) driver.  I don't
think this would cause your problem, but it's possible, maybe try without
it.

> and though the cardmgr loads it does not respond to card events,
> i.e. inserting a card produces *no* effect, there is not a beep, or
> any logged messages.  Rebooting with 2.2.17 fixes the problem and
> 2.4.2 then works again.  It looks to me like something in the PCI bus
> isn't setup correctly by the 2.4 kernels, but chasing that down is way
> beyond my ability, hence the post to linux-kernel.

What's strange is that I have the exact same type of machine and I don't see
this problem, could you forward me your kernel config as well?  I'll compare
that, and your info from your previous message to mine and see if we can
find a difference.

Later,
Tom


