Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbUL0PdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUL0PdB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbUL0PdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:33:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43931 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261905AbUL0Pcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:32:50 -0500
Subject: Re: Linux 2.6.10-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e041226174019e75e23@mail.gmail.com>
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>
	 <58cb370e041226174019e75e23@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104157732.20952.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 14:28:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 01:40, Bartlomiej Zolnierkiewicz wrote:
> > Do you want to force people to disable the io-apic just because of
> > option removal? In my case the serialized devices are a disk and a
> > dvd-rw which is rarely used, so disabling the io-apic is a bad solution.
> 
> No, I want them to fix the problem - whenever it is - ide or apic code. :)

Or hardware, or SMM ....

There are some very complex obscure platform specific funnies that end
up solved by serialize that I doubt anyone will get to the bottom of
before all the worlds parallel ATA drives have turned to rust (and/or
sand).

It seems the gnome desktop disease[1] is spreading to some kernel
people. It's all init code, its cheap and it works. Making it automated
in more cases is great, but you'll never stamp out the need for the
manual one even if its to do the debug to get the automated case right.

Alan

[1] Removing configuration features people need before (if ever)
providing a working alternative that is automatic.

