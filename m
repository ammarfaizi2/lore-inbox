Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbTBFTtp>; Thu, 6 Feb 2003 14:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbTBFTtp>; Thu, 6 Feb 2003 14:49:45 -0500
Received: from ausadmmsrr502.aus.amer.dell.com ([143.166.83.89]:5393 "HELO
	AUSADMMSRR502.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S267353AbTBFTto>; Thu, 6 Feb 2003 14:49:44 -0500
X-Server-Uuid: 586817ae-3c88-41be-85af-53e6e1fe1fc5
Message-ID: <20BF5713E14D5B48AA289F72BD372D680211AAD4@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: hch@infradead.org, markh@osdl.org, atulm@lsil.com
cc: torvalds@transmeta.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH 2.5] fix megaraid driver compile error
Date: Thu, 6 Feb 2003 13:59:16 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 125C611F689684-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any reason we can't jump straight to the v2 driver instead of fixing
> the now obsolete driver?

Atul told linux-megaraid-devel last week that there's at least one important
change to the ISR interaction with firmware that needs to be made, as well
as a broken SCSI RESERVATION_STATUS command.  He is addressing these and
will submit a 2.00.3 driver soon (I hope).

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

