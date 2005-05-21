Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVEUM76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVEUM76 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 08:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVEUM76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 08:59:58 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:58305 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261734AbVEUM74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 08:59:56 -0400
Date: Sat, 21 May 2005 08:59:50 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Greg KH <greg@kroah.com>
cc: Emilyr@us.ibm.com, Kylene@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-security-module@mail.wirex.com,
       Reiner Sailer <sailer@watson.ibm.com>, toml@us.ibm.com
Subject: Re: [PATCH 4 of 4] ima: module measure extension
Message-ID: <Pine.WNT.4.63.0505210838390.2580@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH <greg@kroah.com> wrote on 05/21/2005 02:31:51 AM:

> On Fri, May 20, 2005 at 10:01:18AM -0400, Reiner Sailer wrote:
> > @@ -1441,6 +1442,8 @@ static struct module *load_module(void _
> >     if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
> >        goto truncated;
> >  
> > +   ima_measure_module((void *)hdr, len, (void *)uargs);
> > +
> 
> I see you did not run this code through sparse...
> 
> Gotta love security code that makes the overall system less secure...
> 
> greg k-h

[accumulative to your e-mails today on this topic]

Thanks Greg for all your work going (painfully) through the 
patches I submitted.

Time for me to start learning from my mistakes and getting
a better version out.

Thanks
Reiner


