Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131528AbRAPW7U>; Tue, 16 Jan 2001 17:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132131AbRAPW7K>; Tue, 16 Jan 2001 17:59:10 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:10756 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S131528AbRAPW7A>; Tue, 16 Jan 2001 17:59:00 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E9519D@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Peter Samuelson'" <peter@cadcamlab.org>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 17:54:36 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You seem to be full of things that "we" can implement.  So I just have
> to wonder: do you by any chance have some prototype code somewhere to
> figure out, reliably, which SCSI cards have BIOS extensions enabled,
> and the order they hook in?
> 
	[Venkat] It would be a very bad idea for the linux kernel to look
into the card to see whether the BIOS for that card has been enabled to make
it determine the scsi drive order. If you had followed the earlier threads,
the correct way to proceed would be to use labels to make things node
independent. I think Andreas is working on patch for 2.2.18 and 2.4.0
kernel. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
