Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274573AbRIYJen>; Tue, 25 Sep 2001 05:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274574AbRIYJee>; Tue, 25 Sep 2001 05:34:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38928 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274573AbRIYJeS>; Tue, 25 Sep 2001 05:34:18 -0400
Subject: Re: Burning a CD image slow down my connection
To: andy80@pegacity.it ([A]ndy80)
Date: Tue, 25 Sep 2001 10:39:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1001401550.1017.4.camel@piccoli> from "[A]ndy80" at Sep 25, 2001 09:05:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15loh3-0005PD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If, (for example), I'm downloading a file at 4 k/s and then I start to
> burn an image, some files or other thing from my HD to a CD-R, the
> connection speed goes to 0,1 or 1 k/s max.
> 
> This happen since 2.4.x kernel series.

Make sure you have DMA enabled for your IDE cd-rom or ide unmasking enabled
for it (see man hdparm)
