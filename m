Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVBZXSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVBZXSe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVBZXSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:18:34 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:18915 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261295AbVBZXSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:18:30 -0500
Date: Sat, 26 Feb 2005 20:18:28 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
Message-ID: <20050226231828.GB4010@ime.usp.br>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
References: <20050224015859.55191.qmail@web40910.mail.yahoo.com> <421D3D33.9060707@pobox.com> <20050226193255.GA6256@ime.usp.br> <4220D9DE.10904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4220D9DE.10904@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thank you very much for your reply, Jeff.

On Feb 26 2005, Jeff Garzik wrote:
> "irq XX: nobody cared" is a screaming interrupt situation, which could
> have 1001 causes.

Ok, I didn't know that.

> Normally it's something that "pci=biosirq" or "acpi=off" will fix, but 
> on occasion the driver itself is what needs fixing.

Well, I already tried both of those options (and some others too) and
nothing seems to make my kernel quiet regarding my Promise controller (just
as a reminder, it is a PDC20265, embedded in my Asus A7V motherboard).

If you want me to test any patches, feel free to contact me.


Thanks, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
