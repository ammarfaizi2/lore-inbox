Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313128AbSDOJaJ>; Mon, 15 Apr 2002 05:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313130AbSDOJaI>; Mon, 15 Apr 2002 05:30:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22803 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313128AbSDOJaH>; Mon, 15 Apr 2002 05:30:07 -0400
Subject: Re: Memory Leaking. Help!
To: ivan@es.usyd.edu.au (ivan)
Date: Mon, 15 Apr 2002 10:09:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204151017480.20961-100000@dipole.es.usyd.edu.au> from "ivan" at Apr 15, 2002 10:28:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16x2Tz-0005kV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What does ps -aux imply has all the memory ?
> Top at 9am showed 3.2GB of availabe memory.
> Top at 10am showed 2.3Gb of available memory

That seems reasonable. The kernel knows free memory is waste. Until it
has used all the available memory why does it need to worry about freeing
caches ?

Alan
--
	First the west got slaves by raiding their nations
	Then the west got slaves by invading their nations
	Now the west gets slaves from unrepayable loans to their nations
	Next the west will get slaves from owning their ideas
