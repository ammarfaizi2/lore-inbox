Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270621AbTGUQwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTGUQwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:52:14 -0400
Received: from gsd.di.uminho.pt ([193.136.20.132]:51073 "EHLO
	bbb.lsd.di.uminho.pt") by vger.kernel.org with ESMTP
	id S270621AbTGUQvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:51:32 -0400
Date: Mon, 21 Jul 2003 18:06:34 +0100
From: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>
To: Viaris <bmeneses_beltran@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with kernel 2.5.75 (Urgent)
Message-ID: <20030721170634.GA5633@lsd.di.uminho.pt>
Mail-Followup-To: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>,
	Viaris <bmeneses_beltran@hotmail.com>, linux-kernel@vger.kernel.org
References: <Law11-OE21KRfcjcMzf0000fbd6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law11-OE21KRfcjcMzf0000fbd6@hotmail.com>
User-Agent: Mutt/1.4.1i
X-Disclaimer: 'Author of this message is not responsible for any harm done to reader's computer.'
X-Organization: 'GSD'
X-Section: 'BIC'
X-Priority: '1 (Highest)'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Module loading has changed in 2.5.x. Do you have module-init-tools installed?

You may get it at http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

Regards,
Luciano Rocha

On Mon, Jul 21, 2003 at 10:43:25AM -0600, Viaris wrote:
> Hi all,
> 
> I compiled kernel version 2.5.75, before I had kernel 2.4.20, the problem is
> that I need to enable SCSI DC395x, but when I execute lsmod I not found
> neither modules loaded, only appear:
> Module                  Size  Used by
> 
> If I mount manually a module (insmod
> /lib/modules/2.5.75/kernel/drivers/scsi/dc395x.ko) the following message
> appear: Error inserting
> '/lib/modules/2.5.75/kernel/drivers/scsi/dc395x.ko': -1 Unknown symbol in
> module, I have my modules.conf in the directory /lib/modules/2.5.75/ but
> this kernel no load automatically the modules.
> 
> I need to load this module because Ineed to use the tape backup, I have a
> backu that I need urgent.
> 
> How can I do it?
> 
> Thanks,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
