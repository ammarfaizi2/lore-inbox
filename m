Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264626AbRFPNfc>; Sat, 16 Jun 2001 09:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbRFPNfW>; Sat, 16 Jun 2001 09:35:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19979 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264626AbRFPNfI>; Sat, 16 Jun 2001 09:35:08 -0400
Subject: Re: Changing CPU Speed while running Linux
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 16 Jun 2001 14:23:33 +0100 (BST)
Cc: arjanv@redhat.com (Arjan van de Ven), geg@iitb.fhg.de (Sven Geggus),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010614131220.A36@toy.ucw.cz> from "Pavel Machek" at Jun 14, 2001 01:12:20 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15BG33-00083s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you dig that out? I'd like to take a look.
> 
> [Of course, problem is *not* solved: you still have short time when
> kernel runs with wrong bogomips.]

Not really. WHen you do the speed change on most of these cpus you have to
do it with IRQs off and with the PCI bridge temporarily disabled as the CPU
disconnects from the bus during speed transititions and cannot take part in
cache coherency
