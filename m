Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274829AbRIUU47>; Fri, 21 Sep 2001 16:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274830AbRIUU4j>; Fri, 21 Sep 2001 16:56:39 -0400
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:912 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S274829AbRIUU43>; Fri, 21 Sep 2001 16:56:29 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ray Bryant <raybry@timesn.com>
Cc: <gibbs@FreeBSD.org>, <linux-kernel@vger.kernel.org>
Subject: Re: AIC-7XXX driver problems with 2.4.9 and L440GX+
Date: Fri, 21 Sep 2001 22:56:33 +0200
Message-Id: <20010921205633.2909@smtp.wanadoo.fr>
In-Reply-To: <3BABA9F4.3677E423@timesn.com>
In-Reply-To: <3BABA9F4.3677E423@timesn.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>scsi0:0:0:0: Attempting to queue an ABORT message
>scsi0:0:0:0: Command already completed
>aic7xxx_abort returns 8194
>scsi0:0:0:0: Attempting to queue an ABORT message
>scsi0:0:0:0: Device is active, asserting ATN
>Recovery code sleeping
>Recovery code awake
>Timer Expired
>aic7xxx_abort returns 8195
>scsi0:0:0:0: Attempting to queue a TARGET RESET message
>aic7xxx_dev_reset returns 8195
>Recovery SCB completes
>scsi0:0:0:0: Attempting to queue an ABORT message
>ahc_intr: HOST_MSG_LOOP bad phase 0x0
>scsi0:0:0:0: Cmd aborted from QINFIFO
>aic7xxx_abort returns 8194
>scsi: device set offline - not ready or command retry failed after bus
>reset: host 0 channel 0 id 0 lun 0
><output snipped>

That's interesting as it appears to be the exact same problem I'm having
on my G4 PowerMac with a 2960 card and recent kernels. The 6.2.3 driver
didn't help (Justin, see the log I sent you).

Regards,
Ben.


