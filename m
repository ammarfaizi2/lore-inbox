Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291079AbSBGCVv>; Wed, 6 Feb 2002 21:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291075AbSBGCVl>; Wed, 6 Feb 2002 21:21:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56336 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291072AbSBGCVZ>; Wed, 6 Feb 2002 21:21:25 -0500
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Thu, 7 Feb 2002 02:34:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        cfriesen@nortelnetworks.com (Chris Friesen)
In-Reply-To: <Pine.LNX.4.44.0202062101390.4832-100000@age.cs.columbia.edu> from "Ion Badulescu" at Feb 06, 2002 09:09:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YeOC-0007J5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > UDP is not flow controlled.
> 
> No, of course not, but this has *nothing* to do with UDP. The IP socket 
> itself is flow controlled, and so is the TX queue of the network driver.

It is not flow controlled

> Let me give you another example: ping -f. If what you said were true, ping -f 
> would send packets as fast as the CPU can generate into the black hole 
> called an IP raw socket, right? Well, that just doesn't happen, because 

Wrong. man ping. ping -f doesn't do what you apparently think it does.

Alan
