Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSDMRc2>; Sat, 13 Apr 2002 13:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSDMRc1>; Sat, 13 Apr 2002 13:32:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292870AbSDMRc0>; Sat, 13 Apr 2002 13:32:26 -0400
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
To: andre@linux-ide.org (Andre Hedrick)
Date: Sat, 13 Apr 2002 18:38:49 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        rmk@arm.linux.org.uk (Russell King), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10204130948430.489-100000@master.linux-ide.org> from "Andre Hedrick" at Apr 13, 2002 10:06:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16wRU9-0000hL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The global "wheee I'm a poor and can't afford 32 bit IO" option will remain
> > there of course.
> > 
> > So we have no  issue here. OK?

What if the user doesn't know the precise innards of their hardware. IDE
more than anything else has to automagically do the right thing. Given the
size of the PIO transfer loop and the way for some boards its weirdly 
dependant on hardware magic and wonder is there any reason for not just 
making the host controller provide the function or reference an ide library
function for "sane" hardware ?
