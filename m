Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRJYMQr>; Thu, 25 Oct 2001 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272838AbRJYMQi>; Thu, 25 Oct 2001 08:16:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29199 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273065AbRJYMQZ>; Thu, 25 Oct 2001 08:16:25 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 25 Oct 2001 13:20:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell), linux-kernel@vger.kernel.org
In-Reply-To: <20011025080342.1865@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at Oct 25, 2001 10:03:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wjVL-0004hk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In this case, "sg" could add itself when opened, and eventually cause
> sleep requests to be rejected for example.

I think SG is the only really special case one reading over the code. 
Disk and CD might want to issue a couple of things (cache flush, unlock
media type stuff) but nothing tricky.

> Well, in fact, I don't think there is real need for the "SCSI disk device"
> node, but that depends pretty much on the new SCSI architecture. 

Sure
