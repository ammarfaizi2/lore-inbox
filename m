Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262332AbRENRJR>; Mon, 14 May 2001 13:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbRENRJH>; Mon, 14 May 2001 13:09:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34054 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262322AbRENRI7>; Mon, 14 May 2001 13:08:59 -0400
Subject: Re: Minor numbers
To: Andries.Brouwer@cwi.nl
Date: Mon, 14 May 2001 18:04:31 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, R.E.Wolff@bitwizard.nl, aqchen@us.ibm.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <UTC200105141705.TAA09642.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at May 14, 2001 07:05:19 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zLln-0000zx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No. Inside the kernel the dev_t type does not really occur.
> The exercise is essentially the patch that I sent last month or so.

mknod takes a 32bit input
the stat64 padding only has room for 32bits

The kernel representation internally I dont care about, its probably a pointer
not a 32:32 though

