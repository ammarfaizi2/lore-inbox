Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWHQLbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWHQLbH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWHQLbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:31:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7594 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964811AbWHQLbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:31:05 -0400
Subject: Re: Merging libata PATA support into the base kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Lee Trager <Lee@PicturesInMotion.net>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jason Lunz <lunz@falooley.org>, Jens Axboe <axboe@suse.de>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Stefan Seyfried <seife@suse.de>
In-Reply-To: <20060817094512.GD17899@elf.ucw.cz>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex>
	 <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net>
	 <20060817091842.GC17899@elf.ucw.cz>
	 <1155808348.15195.55.camel@localhost.localdomain>
	 <20060817094512.GD17899@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 12:51:31 +0100
Message-Id: <1155815491.15195.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 11:45 +0200, ysgrifennodd Pavel Machek:
> This should not be it... it also happens on suspend-to-disk according
> to the report, and during swsusp we do normal boot so HPA should be
> initialized...?

The suspend to disk case I've not personally seen. The suspend to ram
one I have looked at and seen and verified the HPA was not reset.

