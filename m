Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276099AbRJYUTs>; Thu, 25 Oct 2001 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276247AbRJYUTi>; Thu, 25 Oct 2001 16:19:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25619 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276099AbRJYUTT>; Thu, 25 Oct 2001 16:19:19 -0400
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Thu, 25 Oct 2001 21:22:24 +0100 (BST)
Cc: _deepfire@mail.ru (Samium Gromoff), alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011025160103.I23000@redhat.com> from "Benjamin LaHaise" at Oct 25, 2001 04:01:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wr1E-00068I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Oct 25, 2001 at 11:30:18PM +0400, Samium Gromoff wrote:
> >        Hello folks...
> > 
> > 	Host A: p166, ISA NE2K, linux-2.4.12-ac4
> > 	Host B: p2-400, rtl-8129, WinXP (heh, not my box though ;)
> > 
> > 	Load: smbmount connection from host A to the host B, and getting
> >      large files.
> 
> Solution: replace NE2K with a decent network card.

The ne2k driver goes to great pains to keep interrupts enabled it isnt the
culprit as far as I can tell
