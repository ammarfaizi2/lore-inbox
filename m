Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279822AbRJ3JO1>; Tue, 30 Oct 2001 04:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279884AbRJ3JOH>; Tue, 30 Oct 2001 04:14:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9489 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279822AbRJ3JN6>; Tue, 30 Oct 2001 04:13:58 -0500
Subject: Re: Ease of hardware configuration
To: landley@trommello.org
Date: Tue, 30 Oct 2001 09:19:30 +0000 (GMT)
Cc: joshhansen@byu.edu (Josh Hansen), linux-kernel@vger.kernel.org
In-Reply-To: <0110292127070I.05062@localhost.localdomain> from "Rob Landley" at Oct 29, 2001 10:27:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yV3S-0005rf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> stuff.  You can't hotplug PCI.  (Well, you can, but not if you expect it to 
> WORK.  Or if you don't want to replace burned out pieces of hardware.)  

You can hotplug PCI. It's called cardbus. There is also full hotplug PCI
in the -ac kernel tree for people with expensive motherboards. The kernel
handles a fair bit of it ok. Hotplugging the video console isnt a good
idea right now, and the disk drivers need work, but for basic stuff like
network cards it works out.

Alan
