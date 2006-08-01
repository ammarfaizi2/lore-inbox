Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWHAN2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWHAN2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWHAN2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:28:12 -0400
Received: from web25806.mail.ukl.yahoo.com ([217.12.10.191]:47237 "HELO
	web25806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932654AbWHAN2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:28:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=X/UlXMUiRhVMelcZb/p8gPMCSeR1SmLOG6qqG31kQWZq0ijmtVR5LSuw7LVkeCr6unU8apZ6R8tiQlBtT1TGl41P6bn/KFlYH1zYT+/bgpr2EW4eVH8e15oJuwr2xz1OcCTRRjhVTsKwrFDI2vJ8C2lR2JZEqWCwX1m1HA9VoBc=  ;
Message-ID: <20060801132810.388.qmail@web25806.mail.ukl.yahoo.com>
Date: Tue, 1 Aug 2006 13:28:10 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : [HW_RNG] How to use generic rng in kernel space
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mb@bu3sch.de, linux-kernel@vger.kernel.org
In-Reply-To: <1154438995.15540.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> O_NONBLOCK doesn't necessarily imply "never sleep", it implies "don't
> sleep waiting for an event/long time". So where the mutex is just
> serializing access to hardware that will be very brief it is fine not to
> check O_NONBLOCK/FNDELAY.

Thank you Alan for answering ! One more question I hope you don't mind...
I'm not very confident with all these POSIX definitions. Do you have any
pointers that I should know to get more familiar with them ?

Thanks

Francis





