Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSFUXYT>; Fri, 21 Jun 2002 19:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316603AbSFUXYS>; Fri, 21 Jun 2002 19:24:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316600AbSFUXYR>; Fri, 21 Jun 2002 19:24:17 -0400
Subject: Re: Need IDE Taskfile Access
To: andre@linux-ide.org (Andre Hedrick)
Date: Sat, 22 Jun 2002 00:45:27 +0100 (BST)
Cc: arcolin@arcoide.com (Garet Cammer), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10206180917550.3804-100000@master.linux-ide.org> from "Andre Hedrick" at Jun 18, 2002 09:22:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LY5o-0001sz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Imagine our surprise when we discovered that taskfile access was being abandoned completely!
> Although we understand that the kernel may need to filter some commands, why can't applications access at least the Smart commands? Help!
> Regards,
> Garet Cammer
> Software Development
> Arco Computer Products
> > (954) 925-2688
> 

The 2.5 code is rather in flux, various things are changing including
redoing generalised ide/scsi generic command access to be a lot more
consistent that ioctl back doors.

I wouldnt worry about it just yet
