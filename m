Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQLFXou>; Wed, 6 Dec 2000 18:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbQLFXok>; Wed, 6 Dec 2000 18:44:40 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:14867 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129627AbQLFXoT>;
	Wed, 6 Dec 2000 18:44:19 -0500
Message-ID: <3A2EC824.3C814C48@mandrakesoft.com>
Date: Wed, 06 Dec 2000 18:13:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jerdfelt@valinux.com, usb@in.tum.de
Subject: Re: test12-pre6
In-Reply-To: <20001206200803.C847@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com> <20001206210928.G847@arthur.ubicom.tudelft.nl> <3A2EAA62.1DB6FCCC@mandrakesoft.com> <3A2EC472.40900@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> Hmm.  Your patch doesn't test whether pci_enable_device(dev)
> was successful, does it?

eh?  It's self-evident from Erik's patch that pci_enable_device's return
call is already being tested, thus you only need to add a call to
pci_set_master.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
