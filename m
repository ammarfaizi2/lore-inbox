Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273990AbRIURYq>; Fri, 21 Sep 2001 13:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274266AbRIURYa>; Fri, 21 Sep 2001 13:24:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60933 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273990AbRIURXW>; Fri, 21 Sep 2001 13:23:22 -0400
Subject: Re: spurious interrupt with ac kernel but not with vanilla 2.4.9
To: kernel@Expansa.sns.it (Luigi Genoni)
Date: Fri, 21 Sep 2001 18:28:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0109211905530.31425-100000@Expansa.sns.it> from "Luigi Genoni" at Sep 21, 2001 07:14:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kU6U-0000cK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The APIC only applies to multiprocessor boxes unless you are building with
> > uniprocessor apic support. Build a non SMP kernel without apic support
> > and let me know what that does
> 
> yes, i was using a non SMP kernel with both apic and io_apic support
> enabled.

Ok.

> actally:
> 
> with APIC support
> and
> without IO_APIC support
> 
> I do not get this message again, but I am so sorry, because my processor
> has integrated APIC support.

Oh your configuration options should have worked. Its more a case of working
out now why the didnt. Knowing that it is uniprocessor apic triggered is a
help there
