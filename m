Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288114AbSAHQCE>; Tue, 8 Jan 2002 11:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288116AbSAHQBn>; Tue, 8 Jan 2002 11:01:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53010 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288114AbSAHQBj>; Tue, 8 Jan 2002 11:01:39 -0500
Subject: Re: IDE Patch (fwd)
To: marcel@mesa.nl
Date: Tue, 8 Jan 2002 16:12:32 +0000 (GMT)
Cc: crimsun@email.unc.edu (Dan Chen), linux-kernel@vger.kernel.org
In-Reply-To: <20020108164035.D22535@joshua.mesa.nl> from "Marcel J.E. Mol" at Jan 08, 2002 04:40:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NyrY-0006tW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which I run on my laptop because it is the latest kernel
> that flushes the ide-drive writecache at shutdown.
> Before that I had regular filesystem corruptions...

For certain laptops with IBM 2.5" drives its basically
mandatory. Any laptops that needed the Win98 update (or were shipped with
the win98 update) for this.

Current sysvinit/initscripts has a sort of unreliable workaround for this,
which doesn't always help.
