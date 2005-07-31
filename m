Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbVGaA37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbVGaA37 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVGaA37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:29:59 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:9025 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263134AbVGaA36 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:29:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sMCTctHrBgBUTUFSnu/8Pj3zwhujYqyNDWkf3HUBuDjbDf414anYiNbgboaV+qG18wqWVGtUViaZ5uS3aoezigf/N5FiR+ainp6CXf17bUA21EZKwq5PtWwuyy9tQ8op3SteHTOl8ctdJzkygV+7m9NyRlXdnHCtNxmRl7YtQkQ=
Message-ID: <21d7e99705073017295ed29c64@mail.gmail.com>
Date: Sun, 31 Jul 2005 10:29:58 +1000
From: Dave Airlie <airlied@gmail.com>
To: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: S3 resume and serial console..
In-Reply-To: <20050730085558.A7770@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0507300301370.13092@skynet>
	 <20050730085558.A7770@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I've set up an i865 machine with a serial console, and on-board graphics
> > (also have radeon/MGA AGP..) and in an effort to try and figure out some
> > more about suspend /resume to RAM..
> >
> > However now the  serial port doesn't come back after resume, I just get
> > garbage sent out on it ...
> >
> > Anyone any ideas?
> 
> Not without some information such as the kernel messages right up to
> the failure point, kernel version and a description of the hardware.

latest Linus git tree, and it just does the usual entering suspend and
then when I resume I get crap out of the serial port, nothing at all
intelliigble...

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

And as I said its an i865 based motherboard from Intel... nothing
special on it, do you need to know the super-io chip, i.e. I 'll have
to open the case to find out...

Dave.
