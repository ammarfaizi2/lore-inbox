Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWHLRqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWHLRqI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWHLRqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:46:08 -0400
Received: from mail04.hansenet.de ([213.191.73.12]:32152 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP
	id S1030240AbWHLRqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:46:06 -0400
From: Thomas Koeller <thomas.koeller@baslerweb.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Date: Sat, 12 Aug 2006 19:45:52 +0200
User-Agent: KMail/1.9.3
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <1155326835.24077.116.camel@localhost.localdomain>
In-Reply-To: <1155326835.24077.116.camel@localhost.localdomain>
Organization: Basler AG
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608121945.52202.thomas.koeller@baslerweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 22:07, Alan Cox wrote:
> Also if this is a software watchdog why is it better than using
> softdog ?
>

This is _not_ a software watchdog. If the timer expires, an interrupt
is generated, and the timer is reset to count through another cycle.
If it expires again, it resets the CPU.

Thomas

-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
