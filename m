Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312834AbSCZXbu>; Tue, 26 Mar 2002 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312842AbSCZXbe>; Tue, 26 Mar 2002 18:31:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56330 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312833AbSCZXas>; Tue, 26 Mar 2002 18:30:48 -0500
Subject: Re: readv() return and errno
To: Andries.Brouwer@cwi.nl
Date: Tue, 26 Mar 2002 23:40:47 +0000 (GMT)
Cc: balbir_soni@yahoo.com, jholly@cup.hp.com, plars@austin.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <UTC200203262115.VAA429771.aeb@cwi.nl> from "Andries.Brouwer@cwi.nl" at Mar 26, 2002 09:15:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16q0YZ-0004Cu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The above ERRORS section says: In case this call returns EINVAL
> one of the possible reasons is that an invalid argument was given.
> There do exist Unix-like systems (not necessarily Linux) that
> consider a zero count invalid.

Got me as well - by that meaning you are correct -  the man page is only
wrong for ssize_t type stuff.

Sorry

Alan
