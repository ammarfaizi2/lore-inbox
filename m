Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284217AbRLKXmZ>; Tue, 11 Dec 2001 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284218AbRLKXmR>; Tue, 11 Dec 2001 18:42:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284217AbRLKXmI>; Tue, 11 Dec 2001 18:42:08 -0500
Subject: Re: NULL pointer dereference in moxa driver
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Tue, 11 Dec 2001 23:51:21 +0000 (GMT)
Cc: xi@borderworlds.dk (Christian Laursen), linux-kernel@vger.kernel.org
In-Reply-To: <200112112323.AAA23377@webserver.ithnet.com> from "Stephan von Krawczynski" at Dec 12, 2001 12:23:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DwgD-0007R1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most interestingly the moxa-driver is better by far than the mxser. It
> seems to me the mxser is _really_ old. If you want to help us all,    

mxser, like the boards the moxa mxser driver supports is very old.

> I cannot submit a patch to marcelo, because I am not the maintainer,  
> and we all don't want to fork a new mxser-driver apart from the       
> original.                                                             

There is no maintainer, and our code base has drifted a fair way from what
moxa originally submitted (being a 2.0 driver with the serial transmit race
bug).

Anyone who wants to beat the mxser driver into shape, go for it.
