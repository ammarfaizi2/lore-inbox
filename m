Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265052AbRFZRed>; Tue, 26 Jun 2001 13:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265053AbRFZReW>; Tue, 26 Jun 2001 13:34:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26633 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265052AbRFZReP>; Tue, 26 Jun 2001 13:34:15 -0400
Subject: Re: AIC7xxx kernel driver; ATTN Mr. Justin T. Gibbs
To: myemail@mycompany.com
Date: Tue, 26 Jun 2001 18:33:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B38C4D2.EB2A8944@mycompany.com> from "myemail@mycompany.com" at Jun 26, 2001 01:22:26 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ewis-0003ul-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel 2.4.3.  Kernels below 2.4 doesn't even see it.  In MS Windows 95
> it works without any problems.  I used 3 variations of SCSI controllers
> built upon AIC7890, so I don't think all 3 are bad.  One was made for
> Compaq and two for Dell.  The AIC7890 is around since a while so that's
> the problem with Linux in corp. computing.  It's great but cannot use

One useful thing to try would be to try the old aic7xx driver (say N to 
aic7xxx and it will offer you the old one). Clearly if the aic7xxx_old driver
works then it is rather good information.

Except for an obscure bug under very high memory load I'm not aware of any 
outstanding bugs in the AIC7xxx driver, certainly not like you describe. There
is however always a first time for any bug 8)


Alan

