Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310474AbSCPReN>; Sat, 16 Mar 2002 12:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310479AbSCPRdz>; Sat, 16 Mar 2002 12:33:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4105 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310474AbSCPRdi>; Sat, 16 Mar 2002 12:33:38 -0500
Subject: Re: [PATCH], tiser module: TI graphing calculators
To: roms@lpg.ticalc.org
Date: Sat, 16 Mar 2002 17:49:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel List),
        zwane@linux.realnet.co.sz (Zwane Mwaikambo),
        alan@lxorguk.ukuu.org.uk (Alan Cox), tytso@mit.edu (Theodore T'so)
In-Reply-To: <3C937EBD.C0308D21@free.fr> from "Romain =?iso-8859-1?Q?Li=E9vin?=" at Mar 16, 2002 06:19:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mIJB-0006oL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This driver directly accesses some UART registers in a way similar to
> serial.c. 
> A better method should be to do some ioctl for toggling UART lines
> rather than by-passing the ttySx driver.

TIOCM* sounds promising. You ought to be able to bitbang enough lines in
user space not to need a driver. 
