Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288951AbSBDMDw>; Mon, 4 Feb 2002 07:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSBDMDm>; Mon, 4 Feb 2002 07:03:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48401 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288936AbSBDMDi>; Mon, 4 Feb 2002 07:03:38 -0500
Subject: Re: Asynchronous CDROM Events in Userland
To: andersen@codepoet.org
Date: Mon, 4 Feb 2002 12:16:33 +0000 (GMT)
Cc: calin@ajvar.org (Calin A. Culianu), linux-kernel@vger.kernel.org
In-Reply-To: <20020204070414.GA19268@codepoet.org> from "Erik Andersen" at Feb 04, 2002 12:04:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Xi2z-00073m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jens Axboe and I wrote a little test app a year or two ago to check
> for whether drives supported asynchronous mode.  We found it to be
> unsupported on 100% of the drives we tested (and we tested quite a
> few)...

I also found no drive with asynchronous and at best patchy and dubious
synchronous notification. Many cheap drives don't report an event if you
push the button with the door locked for example.

Something like volumagic, cleaned up, is a much better solution
