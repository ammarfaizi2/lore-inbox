Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTH0Tco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 15:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTH0Tco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 15:32:44 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:28842 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S262023AbTH0Tcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 15:32:42 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308271933.UAA14620@mauve.demon.co.uk>
Subject: Re: usb-storage: how to ruin your hardware(?)
To: root@chaos.analogic.com
Date: Wed, 27 Aug 2003 20:33:07 +0100 (BST)
Cc: kernel@wildsau.idv.uni.linz.at ("H.Rosmanith (Kernel Mailing List)"),
       alan@lxorguk.ukuu.org.uk (Alan Cox),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.53.0308271123480.659@chaos> from "Richard B. Johnson" at Aug 27, 2003 11:37:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, 27 Aug 2003, H.Rosmanith (Kernel Mailing List) wrote:
> 
> > > > "after the first write the flash device failed entirely". That doen't
<snip>
> Remember when AT Class machines had a BIOS that allowed you
> to low-level format hard drives? When early IDE drives came
> out, persons tried to format them and they got destroyed.
> So, BIOS vendors took away the format capability.
> 
> The IDE drive companies started a lie that was repeated so
> often that it seemed true. It was that IDE drives didn't
> have 'formatters' and, therefore, could only be formatted
> at the factory. Of course, if this was true, how come
> the format command did anything??  The truth was that

This is actually true, and has been since around 80Mb or so.
There is no absolute positioning information on the disk drive that can
be used to lay down new positioning information for the tracks.
Before this, there used to be a stepper motor that could position the
head at track 743, or a seperate head that read track information from
a dedicated surface. 

> these drives stored their parameters on the disk platters.
> If you re-wrote the first real sectors on the drive, the

This is more likely the problem, but 
