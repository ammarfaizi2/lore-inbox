Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133016AbRDKWzk>; Wed, 11 Apr 2001 18:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133010AbRDKWz0>; Wed, 11 Apr 2001 18:55:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47120 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133015AbRDKWyS>; Wed, 11 Apr 2001 18:54:18 -0400
Subject: Re: [PATCH] i386 rw_semaphores fix
To: hpa@transmeta.com (H. Peter Anvin)
Date: Wed, 11 Apr 2001 23:55:43 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <3AD4DDC7.99017C15@transmeta.com> from "H. Peter Anvin" at Apr 11, 2001 03:42:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nTWd-0007jx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Be careful there. CMOV is an optional instruction. gcc is arguably wrong
> > in using cmov in '686' mode. Building libs with cmov makes sense though
> > especially for the PIV with its ridiculously long pipeline
> 
> It is just a matter how you define "686 mode", otherwise the very concept
> is meaningless.

I use the pentium pro documentation.

