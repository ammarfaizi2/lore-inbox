Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272546AbRIFUOR>; Thu, 6 Sep 2001 16:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRIFUOH>; Thu, 6 Sep 2001 16:14:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16914 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272546AbRIFUOA>; Thu, 6 Sep 2001 16:14:00 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
To: wietse@porcupine.org (Wietse Venema)
Date: Thu, 6 Sep 2001 21:18:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), wietse@porcupine.org (Wietse Venema),
        saw@saw.sw.com.sg (Andrey Savochkin),
        matthias.andree@gmx.de (Matthias Andree), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010906194106.E66BCBC06C@spike.porcupine.org> from "Wietse Venema" at Sep 06, 2001 03:41:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f5b6-0000Ot-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > SIOCGIFCONF is going to give the right data. People doing clever things
> > will have to set up config files. simple easy - hard possible.
> 
> Cool. I will not waste further time on this until someone takes
> SIOCGIFCONF away.

I think that is a reasonable solution. Very few people have configurations
that SIOCGIFCONF cannot properly report. If there are configurations that
are totally sane and SIOCGIFCONF can report but misreports them I consider
it a bug.

Alan
