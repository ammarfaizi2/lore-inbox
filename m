Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTL2Vnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 16:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTL2Vnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 16:43:53 -0500
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:5248 "HELO mail.nicke.nu")
	by vger.kernel.org with SMTP id S264261AbTL2Vnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 16:43:51 -0500
From: "Nicklas Bondesson" <nicke@nicke.nu>
To: "'Arjan van de Ven'" <arjanv@redhat.com>
Cc: "'Christophe Saout'" <christophe@saout.de>, <linux-kernel@vger.kernel.org>
Subject: RE: ataraid in 2.6.?
Date: Mon, 29 Dec 2003 22:43:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20031229173012.GB21479@devserv.devel.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcPOMSB4zWGIfxvHTEmPCpgW+RI1mAAI5qFQ
Message-Id: <S264261AbTL2Vnv/20031229214351Z+17930@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I agree. Duplicating it is rather silly :)

Where did he apply it?

/Nicke

-----Original Message-----
From: Arjan van de Ven [mailto:arjanv@redhat.com] 
Sent: den 29 december 2003 18:30
To: Nicklas Bondesson
Cc: 'Christophe Saout'; linux-kernel@vger.kernel.org
Subject: Re: ataraid in 2.6.?

On Mon, Dec 29, 2003 at 06:27:08PM +0100, Nicklas Bondesson wrote:
> How do you set this (device mapping) up using the 2.6 kernel. I like 
> the ease of using ataraid in 2.4.x. Why not have both alternatives as 
> options (both ataraid and devicemapper)?

because ataraid is nothing more than a devicemapper....
duplicating that is rather silly... 
The outcome is to be a /sbin/ataraid binary or some such that will do all
the magic to detect the raid and tell the kernel device mapper to set it all
up.

> Also have anyone of you looked at the patch from Walt H that he sent 
> in yesterday? I have to use this after replacing my old hard drives 
> (Maxtor 30GB) with WDC 80GB. The patch is attached.

I sent it to Marcelo for applying last week, and he applied it today

