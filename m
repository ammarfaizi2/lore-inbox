Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290718AbSA3W6k>; Wed, 30 Jan 2002 17:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290722AbSA3W6b>; Wed, 30 Jan 2002 17:58:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33543 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290718AbSA3W6Z>; Wed, 30 Jan 2002 17:58:25 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: andersen@codepoet.org
Date: Wed, 30 Jan 2002 23:06:04 +0000 (GMT)
Cc: greg@kroah.com (Greg KH), linux-kernel@vger.kernel.org
In-Reply-To: <20020130211422.GA22705@codepoet.org> from "Erik Andersen" at Jan 30, 2002 02:14:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16W3no-0000Jv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bravery.  That pile of dung does not need a "small-stuff"
> maintainer.  It needs to be forcefully ejected and replaced with
> extreme prejudice.  It is amazing that ancient stuff works as
> well as it does...

A lot of the apparently really ugly drivers turned out to be very good code
hiding under 10 years of history and core code changes and
assumptions. See the NCR5380 stuff I've now all done (in 2.4.18pre) - dont 
use 2.5.* NCR5380 it'll probably corrupt your system if it doesn't just die
or hang - Linus apparently merged untested stuff to the old broken driver.

Alan
