Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317456AbSFMFWh>; Thu, 13 Jun 2002 01:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSFMFWg>; Thu, 13 Jun 2002 01:22:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5391 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317456AbSFMFWe>; Thu, 13 Jun 2002 01:22:34 -0400
Subject: Re: Very large font size crashing X Font Server and Grounding Server to
To: jijo@free.net.ph (Federico Sevilla III)
Date: Thu, 13 Jun 2002 06:39:35 +0100 (BST)
Cc: bugtraq@securityfocus.com (BugTraq Mailing List),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.44.0206130908550.985-100000@kalabaw> from "Federico Sevilla III" at Jun 13, 2002 09:44:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17INKZ-0000gV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> check to prevent such large sizes from crashing X and/or the X Font
> Server, I'm alarmed by (1) the way the X font server allows itself to be
> crashed like this, and (2) the way the entire Linux kernel seems to have
> been unable to handle the situation. While having a central company or

So turn on the features to conrol it. Set rlimits on the xfs server and 
enable non overcommit (-ac kernel)

Alan
