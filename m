Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135889AbRD3TyD>; Mon, 30 Apr 2001 15:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136511AbRD3Txy>; Mon, 30 Apr 2001 15:53:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14084 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135889AbRD3Txj>; Mon, 30 Apr 2001 15:53:39 -0400
Subject: Re: 2.2.19 locks up on SMP
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 30 Apr 2001 20:57:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ionut@cs.columbia.edu (Ion Badulescu),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010430201547.G19620@athlon.random> from "Andrea Arcangeli" at Apr 30, 2001 08:15:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uJnE-0000Di-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Apr 30, 2001 at 06:55:54PM +0100, Alan Cox wrote:
> > A couple. It looks lik the VM changes may have upset something (based on
> > reports saying it began at that point). Can you see if 2.2.19pre stuff is
> > stable ?
> 
> I also have reports but related to the network driver updates. So I
> suggest to try again with 2.2.19 but with the drivers/net/* of 2.2.18.

Thats probably a better starting point. Its easier to back out than the VM
changes and it would also explain the reports I saw.

