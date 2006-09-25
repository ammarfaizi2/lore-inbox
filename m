Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWIYXwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWIYXwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWIYXwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:52:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:40663 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751565AbWIYXwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:52:17 -0400
Message-ID: <45186BAC.70404@pobox.com>
Date: Mon, 25 Sep 2006 19:52:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NV SATA breakage: jgarzik/libata-dev#upstream etc
References: <m3wt7tm6sh.fsf@defiant.localdomain> <451721F8.4060600@pobox.com>	<m3vencjeit.fsf@defiant.localdomain>	<m364fbrhow.fsf@defiant.localdomain> <45185625.4050906@pobox.com> <m3fyef1p6f.fsf@defiant.localdomain>
In-Reply-To: <m3fyef1p6f.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
>> Krzysztof Halasa wrote:
>>> 	ppi[0] = ppi[1] = &nv_port_info[ent->driver_data];
>> That's probably the best solution.
> 
> It fixes the SATA NV problem (I'm not attaching the patch as you already
> posted similar one).

The argument to ata_pci_init_native_mode() was also updated.

Just for sanity's sake, could you test linux-2.5.git + my patch?

	Jeff


