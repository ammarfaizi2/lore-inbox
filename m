Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbRF1OOz>; Thu, 28 Jun 2001 10:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265967AbRF1OOp>; Thu, 28 Jun 2001 10:14:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50188 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265947AbRF1OO3>; Thu, 28 Jun 2001 10:14:29 -0400
Subject: Re: VM Requirement Document - v0.0
To: tori@unhappy.mine.nu (Tobias Ringstrom)
Date: Thu, 28 Jun 2001 15:14:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mike_phillips@urscorp.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106281558250.1258-100000@boris.prodako.se> from "Tobias Ringstrom" at Jun 28, 2001 04:04:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FcYl-00070C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Updatedb is a bit odd in that it mostly sucks in metadata and the buffer to
> > page cache balancing is a bit suspect IMHO.
> 
> In 2.4.6-pre, the buffer cache is no longer used for metata, right?

For ext2 directory blocks the page cache is now used
