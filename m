Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131966AbQLNSY5>; Thu, 14 Dec 2000 13:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131968AbQLNSYr>; Thu, 14 Dec 2000 13:24:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28676 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131966AbQLNSYg>; Thu, 14 Dec 2000 13:24:36 -0500
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 14 Dec 2000 17:56:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        shirsch@adelphia.net, linux-kernel@vger.kernel.org
In-Reply-To: <200012141403.eBEE3Ts46579@aslan.scsiguy.com> from "Justin T. Gibbs" at Dec 14, 2000 07:03:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146ccB-0000JU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm aware of the difference.  I only mentioned "curproc" as an example of
> similar brokeness that has less of a chance of catching the uninitiated.
> What about "curtask" or "curthread"?

Its called current. We write a lot of current->state type things where it makes
a lot of sense. Being a define is ugly because it hits struct fields. Being a
global is sane. Its also something that is inbuilt into every driver and every
book or article on linux driver/kernel stuff. Changing it would be extremely
bad.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
