Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311860AbSCZNZB>; Tue, 26 Mar 2002 08:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311869AbSCZNYv>; Tue, 26 Mar 2002 08:24:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62994 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311860AbSCZNYi>; Tue, 26 Mar 2002 08:24:38 -0500
Subject: Re: Problems with Tigon v0.97
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 26 Mar 2002 13:40:49 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), aj@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CA06B66.7070701@mandrakesoft.com> from "Jeff Garzik" at Mar 26, 2002 07:36:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16prBx-00033y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >It's an amd756 chipset bug.  bcm5700 chooses to work around it in
> >their driver, when it really belongs as a generic PCI fixup in
> >the kernel.
> 
> bcm5700 works around AMD762 bug -- and that workaround should be in 
> stock 2.4.18 and 2.5.7 kernels now as a PCI quirk.  I think something 
> else is going on here...

Its not IMHO a chipset bug either. The documentation on the 762 is
quite explicit. It has a nice table and makes it absolutely clear which modes
are PCI 2.2 compliant.

Alan
