Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272081AbRHVSu2>; Wed, 22 Aug 2001 14:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272082AbRHVSuS>; Wed, 22 Aug 2001 14:50:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47276 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272081AbRHVSuE>;
	Wed, 22 Aug 2001 14:50:04 -0400
Date: Wed, 22 Aug 2001 11:50:02 -0700 (PDT)
Message-Id: <20010822.115002.118611451.davem@redhat.com>
To: jfbeam@bluetopia.net
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.33.0108221431060.6389-100000@sweetums.bluetronic.net>
In-Reply-To: <E15Za6U-0001ht-00@the-village.bc.nu>
	<Pine.GSO.4.33.0108221431060.6389-100000@sweetums.bluetronic.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ricky Beam <jfbeam@bluetopia.net>
   Date: Wed, 22 Aug 2001 14:46:27 -0400 (EDT)

   On Wed, 22 Aug 2001, Alan Cox wrote:
   >Read the source code. The driver never reloads the firmware on a running
   >card. So if the sparc needed that it never worked anyway, and I don't follow
   >your argument.
   
   If the card wasn't setup by the BIOS (OBP in the Sparc case), then the driver
   won't work.  And as late as 2.4.8, RELOAD_FIRMWARE was set to '1'.  Gee,
   look what was changed in 2.4.9:
   
Please read what people are saying.

He said "running card"  Which means that it does not handle the
PCI master case on a running system, which I never claimed it did.

The older code does guarentee that if I did powercycle and reboot
at that point, I will get a functional card back, which the current
code does not do.

Alan's actively trying to resolve this problem by getting usable
firmware from Qlogic.  What are you doing to improve the situation
besides trolling like made on this list?

Later,
David S. Miller
davem@redhat.com
